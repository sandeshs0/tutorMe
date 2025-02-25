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
  late final Future<Khalti> khalti;

  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(FetchWalletDetails());
    // const payConfig = KhaltiPayConfig(
    //   publicKey: 'your_public_key', // Replace with your actual public key
    //   pidx: 'your_generated_pidx', // Replace with the pidx from your backend
    //   environment: Environment.test, // Use Environment.prod for production
    // );
    khalti = Khalti.init(
      enableDebugging: true,
      payConfig: const KhaltiPayConfig(
        publicKey: '0b353ee393f14dd48743e73b7306ed14',
        pidx: '',
        environment: Environment.test,
      ),
      //   final payConfig = KhaltiPayConfig(
      //   publicKey: '0b353ee393f14dd48743e73b7306ed14',
      //   pidx: state.transaction.pidx ?? "",
      //   environment: Environment
      //       .test, // ✅ Use Environment.prod for production
      // );
      onPaymentResult: (paymentResult, khalti) {
        debugPrint("✅ Payment Result: ${paymentResult.payload}");

        context.read<WalletBloc>().add(
              VerifyTransaction(
                  pidx: paymentResult.payload!.pidx!, transactionId: ''),
            );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Payment Successful!")),
        );
        khalti.close(context);
      },
      onMessage: (khalti,
          {description, statusCode, event, needsPaymentConfirmation}) async {
        //   if (needsPaymentConfirmation) {
        //     await khalti
        //         .verify(); // ✅ Manually verify if needed
        //   }
        //   khalti.close(context);
        // },
      },
      onReturn: () => debugPrint('Successfully redirected to return_url.'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "\$${balance.toStringAsFixed(2)}",
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
        onPressed: _showLoadWalletBottomSheet,
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

  /// Bottom Sheet for Entering Amount
  // void _showLoadWalletBottomSheet() {
  //   TextEditingController amountController = TextEditingController();

  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Text("Enter Amount",
  //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //             const SizedBox(height: 15),
  //             TextField(
  //               controller: amountController,
  //               keyboardType: TextInputType.number,
  //               decoration: InputDecoration(
  //                 labelText: "Enter amount",
  //                 prefixIcon: const Icon(FontAwesomeIcons.coins),
  //                 border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(12)),
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //             // Align(
  //             //   alignment: Alignment.centerLeft,
  //             //   child: Text(
  //             //     "Amount must be greater than 50.",
  //             //     style: TextStyle(color: Colors.red.shade700, fontSize: 12),
  //             //   ),
  //             // ),
  //             // const SizedBox(height: 20),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 TextButton(
  //                   onPressed: () => Navigator.pop(context),
  //                   child: const Text("Close",
  //                       style: TextStyle(
  //                           // color: Color.fromARGB(255, 59, 59, 59),
  //                           fontSize: 16)),
  //                 ),
  //                 ElevatedButton(
  //                   onPressed: () {
  //                     final amount =
  //                         double.tryParse(amountController.text) ?? 0;
  //                     if (amount >= 50) {
  //                       context.read<WalletBloc>().add(
  //                             InitiateTransaction(
  //                               amount: amount,
  //                               paymentGateway: "Khalti",
  //                             ),
  //                           );
  //                       Navigator.pop(context);
  //                     } else {
  //                       ScaffoldMessenger.of(context).showSnackBar(
  //                         const SnackBar(
  //                             content: Text("Amount must be greater than 50.")),
  //                       );
  //                     }
  //                   },
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: const Color.fromARGB(255, 99, 2, 117),
  //                     padding: const EdgeInsets.symmetric(
  //                         horizontal: 20, vertical: 12),
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(12)),
  //                   ),
  //                   child: const Text("Pay with Khalti",
  //                       style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.bold)),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 10),
  //             // Row(
  //             //   mainAxisAlignment: MainAxisAlignment.center,
  //             //   children: [
  //             //     const Text("Payment Partner:"),
  //             //     const SizedBox(width: 8),
  //             //     Container(
  //             //       padding:
  //             //           const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //             //       decoration: BoxDecoration(
  //             //         color: Colors.purple.shade100,
  //             //         borderRadius: BorderRadius.circular(8),
  //             //       ),
  //             //       child: const Text("Khalti",
  //             //           style: TextStyle(
  //             //               color: Color.fromARGB(255, 66, 1, 78),
  //             //               fontWeight: FontWeight.bold)),
  //             //     ),
  //             //   ],
  //             // ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _showLoadWalletBottomSheet() {
  //   TextEditingController amountController = TextEditingController();

  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Text("Enter Amount",
  //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //             const SizedBox(height: 15),
  //             TextField(
  //               controller: amountController,
  //               keyboardType: TextInputType.number,
  //               decoration: InputDecoration(
  //                 labelText: "Enter amount",
  //                 prefixIcon: const Icon(FontAwesomeIcons.coins),
  //                 border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(12)),
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //             ElevatedButton(
  //               onPressed: () {
  //                 final amount = double.tryParse(amountController.text) ?? 0;
  //                 if (amount >= 50) {
  //                   debugPrint("🟢 Initiating transaction for amount: $amount");

  //                   context.read<WalletBloc>().add(
  //                         InitiateTransaction(
  //                           amount: amount,
  //                           paymentGateway: "Khalti",
  //                         ),
  //                       );

  //                   context.read<WalletBloc>().stream.listen((state) async {
  //                     if (state is TransactionInitiated) {
  //                       debugPrint(
  //                           "✅ Transaction Initiated, Opening Khalti Checkout...");

  //                       final payConfig = KhaltiPayConfig(
  //                         publicKey: 'your_public_key',
  //                         pidx: state.transaction.pidx ?? "",
  //                         environment: Environment
  //                             .test, // ✅ Use Environment.prod for production
  //                       );

  //                       final khalti = await Khalti.init(
  //                         enableDebugging: true,
  //                         payConfig: payConfig,
  //                         onPaymentResult: (paymentResult, khalti) {
  //                           debugPrint(
  //                               "✅ Payment Result: ${paymentResult.payload}");

  //                           context.read<WalletBloc>().add(
  //                                 VerifyTransaction(
  //                                   pidx: paymentResult.payload!.pidx!,
  //                                   transactionId:
  //                                       state.transaction.transactionId ?? "",
  //                                 ),
  //                               );
  //                           ScaffoldMessenger.of(context).showSnackBar(
  //                             const SnackBar(
  //                                 content: Text("Payment Successful!")),
  //                           );
  //                           khalti.close(context);
  //                         },
  //                         onMessage: (khalti,
  //                             {description,
  //                             statusCode,
  //                             event,
  //                             needsPaymentConfirmation}) async {
  //                           //   if (needsPaymentConfirmation) {
  //                           //     await khalti
  //                           //         .verify(); // ✅ Manually verify if needed
  //                           //   }
  //                           //   khalti.close(context);
  //                           // },
  //                         },
  //                         onReturn: () => debugPrint(
  //                             'Successfully redirected to return_url.'),
  //                       );

  //                       debugPrint("🟢 Opening Khalti Checkout...");
  //                       khalti.open(context);
  //                     }
  //                   });

  //                   Navigator.pop(context);
  //                 } else {
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     const SnackBar(
  //                         content: Text("Amount must be greater than 50.")),
  //                   );
  //                 }
  //               },
  //               child: const Text("Pay with Khalti"),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  void _showLoadWalletBottomSheet() {
    TextEditingController amountController = TextEditingController();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Enter Amount",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter amount",
                  prefixIcon: const Icon(FontAwesomeIcons.coins),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 10),
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

                    context.read<WalletBloc>().stream.listen((state) async {
                      if (state is TransactionInitiated) {
                        debugPrint(
                            "✅ Transaction Initiated, Opening Khalti Checkout...");
                        final safeContext = Navigator.of(context)
                            .overlay!
                            .context; // Ensure valid context

                        final updatedPayConfig = KhaltiPayConfig(
                          publicKey: '0b353ee393f14dd48743e73b7306ed14',
                          pidx: state.transaction.pidx ?? "",
                          environment: Environment
                              .test, // ✅ Use Environment.prod for production
                        );

                        // await khalti.then((k) {
                        //   k.payConfig=updatedPayConfig;
                        //   k.open(safeContext);
                        // });
                        // Might work
                        await Khalti.init(
                          enableDebugging: true,
                          payConfig: KhaltiPayConfig(
                            publicKey: '0b353ee393f14dd48743e73b7306ed14',
                            pidx: state.transaction.pidx ?? "",
                            environment: Environment
                                .test, // ✅ Use Environment.prod for production
                          ),
                          onPaymentResult: (paymentResult, khalti) {
                            debugPrint(
                                "✅ Payment Result: ${paymentResult.payload}");

                            context.read<WalletBloc>().add(
                                  VerifyTransaction(
                                    pidx: paymentResult.payload!.pidx!,
                                    transactionId:
                                        state.transaction.transactionId ?? "",
                                  ),
                                );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Payment Successful!")),
                            );
                            khalti.close(context);
                          },
                          onMessage: (khalti,
                              {description,
                              statusCode,
                              event,
                              needsPaymentConfirmation}) async {
                            debugPrint(
                                '🔴 Error: $description, Status Code: $statusCode, Event: $event, Needs Confirmation: $needsPaymentConfirmation');
                          },
                          onReturn: () => debugPrint(
                              '✅ Successfully redirected to return_url.'),
                        ).then((k) {
                          debugPrint("🟢 Opening Khalti Checkout...");
                          k.open(safeContext);
                        });

                        // Migh work

                        Navigator.pop(context);
                        debugPrint("🟢 Opening Khalti Checkout...");
                        // khalti.open(navigatorContext);
                      }
                    });

                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Amount must be greater than 50.")),
                    );
                  }
                },
                child: const Text("Pay with Khalti"),
              ),
            ],
          ),
        );
      },
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
        const SizedBox(height: 10),
        _buildSampleTransaction("Angga Big Park", "10 hours ago", "\$49,509",
            FontAwesomeIcons.buildingColumns),
        _buildSampleTransaction("Top Up", "12 January 2024", "\$43,129,509",
            FontAwesomeIcons.wallet,
            color: Colors.green),
        _buildSampleTransaction("Angga Big Park", "10 hours ago", "\$49,509",
            FontAwesomeIcons.buildingColumns),
      ],
    );
  }
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    ),
  );
}
