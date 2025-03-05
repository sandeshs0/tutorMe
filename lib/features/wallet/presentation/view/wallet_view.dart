import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';
import 'package:tutorme/features/wallet/presentation/view/transaction_history_screen.dart';
import 'package:tutorme/features/wallet/presentation/view_model/bloc/wallet_bloc.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Use a global key for stable context
  StreamSubscription? _subscription; // For cleaning up the stream subscription

  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(FetchWalletDetails());
  }

  void _showLoadWalletDialog() {
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Enter Amount",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Enter amount",
              prefixIcon: const Icon(FontAwesomeIcons.coins),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel", style: TextStyle(fontSize: 16)),
            ),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(amountController.text) ?? 0;
                if (amount >= 50) {
                  debugPrint("🟢 Initiating transaction for amount: $amount");

                  context.read<WalletBloc>().add(
                        InitiateTransaction(
                          amount: amount,
                          paymentGateway: "Khalti",
                        ),
                      );

                  _subscription?.cancel(); // Cancel any existing subscription
                  _subscription =
                      context.read<WalletBloc>().stream.listen((state) async {
                    if (state is TransactionInitiated) {
                      debugPrint(
                          "✅ Transaction Initiated, Opening Khalti Checkout...");

                      final pidx = state.transaction.pidx ?? "";
                      final transactionId =
                          state.transaction.transactionId ?? "";

                      if (pidx.isNotEmpty) {
                        final payConfig = KhaltiPayConfig(
                          publicKey:
                              '59bc2858051d4983b53fd1b2033e9052', // Your test public key
                          pidx: pidx,
                          environment: Environment.test, // Use test environment
                        );

                        final khalti = await Khalti.init(
                          payConfig: payConfig,
                          enableDebugging: true,
                          onPaymentResult:
                              (paymentResult, khaltiInstance) async {
                            debugPrint(
                                "✅ Payment Result: ${paymentResult.payload}");
                            context.read<WalletBloc>().add(
                                  VerifyTransaction(
                                    pidx: paymentResult.payload!.pidx!,
                                    transactionId: transactionId,
                                  ),
                                );
                            // Show the new snackbar message after verification
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Payment Successful, Wallet Updated!")),
                            );
                            khaltiInstance.close(context);
                          },
                          onMessage: (khalti,
                              {description,
                              statusCode,
                              event,
                              needsPaymentConfirmation}) async {
                            debugPrint(
                                '🔴 Error: $description, Status Code: $statusCode, Event: $event, Needs Confirmation: $needsPaymentConfirmation');
                            if (event != KhaltiEvent.returnUrlLoadFailure) {
                              // Only show other payment events, not return URL failures
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Payment event: $event - $description")),
                              );
                            }
                          },
                          // onReturn: (_) {
                          //   // Do nothing or remove this callback entirely since you don't want redirection
                          //   debugPrint('Return URL ignored as per requirement.');
                          // },
                        );

                        debugPrint("🟢 Opening Khalti Checkout...");
                        final navigatorContext = _scaffoldKey.currentContext ??
                            context; // Use scaffold key context or fall back to widget context
                        try {
                          khalti.open(navigatorContext);
                        } catch (e) {
                          debugPrint(" Error opening Khalti: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text("Failed to open Khalti payment: $e")),
                          );
                        }
                      } else {
                        debugPrint("❌ No pidx received for Khalti payment");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Failed to initiate payment. No pidx received.")),
                        );
                      }
                    }
                  });
                  Navigator.pop(dialogContext);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Amount must be greater than 50.")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 99, 2, 117),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Pay with Khalti",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the global key to the Scaffold
      appBar: AppBar(
        title: const Text("Wallet"),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWalletBalance(state),
                const SizedBox(height: 20),
                _buildLoadWalletButton(),
                const SizedBox(height: 20),
                _buildTransactionSection(context),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Wallet Balance Card
  Widget _buildWalletBalance(WalletState state) {
    double balance = 0;
    if (state is WalletLoaded) {
      balance = state.wallet.walletBalance;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Wallet Balance",
                  style: TextStyle(color: Colors.white70, fontSize: 16)),
              IconButton(
                icon: const Icon(FontAwesomeIcons.arrowRotateRight,
                    color: Colors.white70),
                onPressed: () =>
                    context.read<WalletBloc>().add(FetchWalletDetails()),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Rs. ${balance.toStringAsFixed(2)}",
            style: GoogleFonts.lato(
                fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(DateTime.now().toLocal().toString().split(' ')[0],
              style: const TextStyle(color: Colors.white54, fontSize: 14)),
        ],
      ),
    );
  }

  /// Load Wallet Button
  Widget _buildLoadWalletButton() {
    return Center(
      child: TextButton.icon(
        onPressed: _showLoadWalletDialog,
        icon: const Icon(FontAwesomeIcons.plusCircle, color: Colors.green),
        label: const Text("Load Wallet",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.green)),
        ),
      ),
    );
  }

  /// Transaction History Section
  Widget _buildTransactionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Latest Transactions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TransactionHistoryScreen()),
                );
              },
              child: const Text("View All",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 16)),
            )
          ],
        ),
        // const SizedBox(height: 10),
        // _buildSampleTransaction("Angga Big Park", "10 hours ago", "\$49,509",
        //     FontAwesomeIcons.buildingColumns),
        // _buildSampleTransaction("Top Up", "12 January 2025", "\$43,129,509",
        //     FontAwesomeIcons.wallet,
        //     color: Colors.green),
        // _buildSampleTransaction("Angga Big Park", "10 hours ago", "\$49,509",
        //     FontAwesomeIcons.buildingColumns),
      ],
    );
  }

  Widget _buildSampleTransaction(
      String title, String time, String amount, IconData icon,
      {Color color = Colors.blue}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.clock,
                        size: 12, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(time, style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ],
            ),
          ),
          Text(amount,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel(); // Clean up the stream subscription
    super.dispose();
  }
}
