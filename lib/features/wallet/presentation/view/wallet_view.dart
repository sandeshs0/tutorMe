// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';
// import 'package:tutorme/features/wallet/presentation/view/transaction_history_screen.dart';
// import 'package:tutorme/features/wallet/presentation/view_model/bloc/wallet_bloc.dart';

// class WalletView extends StatefulWidget {
//   const WalletView({super.key});

//   @override
//   State<WalletView> createState() => _WalletViewState();
// }

// class _WalletViewState extends State<WalletView> {
//   final GlobalKey<ScaffoldState> _scaffoldKey =
//       GlobalKey<ScaffoldState>(); // Use a global key for stable context
//   StreamSubscription? _subscription; // For cleaning up the stream subscription

//   @override
//   void initState() {
//     super.initState();
//     context.read<WalletBloc>().add(FetchWalletDetails());
//   }

//   void _showLoadWalletDialog() {
//     TextEditingController amountController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           title: const Text("Enter Amount",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           content: TextField(
//             controller: amountController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               labelText: "Enter amount",
//               prefixIcon: const Icon(FontAwesomeIcons.coins),
//               border:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(dialogContext),
//               child: const Text("Cancel", style: TextStyle(fontSize: 16)),
//             ),
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

//                   _subscription?.cancel(); // Cancel any existing subscription
//                   _subscription =
//                       context.read<WalletBloc>().stream.listen((state) async {
//                     if (state is TransactionInitiated) {
//                       debugPrint(
//                           "✅ Transaction Initiated, Opening Khalti Checkout...");

//                       final pidx = state.transaction.pidx ?? "";
//                       final transactionId =
//                           state.transaction.transactionId ?? "";

//                       if (pidx.isNotEmpty) {
//                         final payConfig = KhaltiPayConfig(
//                           publicKey:
//                               '59bc2858051d4983b53fd1b2033e9052', // Your test public key
//                           pidx: pidx,
//                           environment: Environment.test, // Use test environment
//                         );

//                         final khalti = await Khalti.init(
//                           payConfig: payConfig,
//                           enableDebugging: true,
//                           onPaymentResult:
//                               (paymentResult, khaltiInstance) async {
//                             debugPrint(
//                                 "✅ Payment Result: ${paymentResult.payload}");
//                             context.read<WalletBloc>().add(
//                                   VerifyTransaction(
//                                     pidx: paymentResult.payload!.pidx!,
//                                     transactionId: transactionId,
//                                   ),
//                                 );
//                             // Show the new snackbar message after verification
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text(
//                                       "Payment Successful, Wallet Updated!")),
//                             );
//                             khaltiInstance.close(context);
//                           },
//                           onMessage: (khalti,
//                               {description,
//                               statusCode,
//                               event,
//                               needsPaymentConfirmation}) async {
//                             debugPrint(
//                                 '🔴 Error: $description, Status Code: $statusCode, Event: $event, Needs Confirmation: $needsPaymentConfirmation');
//                             if (event != KhaltiEvent.returnUrlLoadFailure) {
//                               // Only show other payment events, not return URL failures
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content: Text(
//                                         "Payment event: $event - $description")),
//                               );
//                             }
//                           },
//                           // onReturn: (_) {
//                           //   // Do nothing or remove this callback entirely since you don't want redirection
//                           //   debugPrint('Return URL ignored as per requirement.');
//                           // },
//                         );

//                         debugPrint("🟢 Opening Khalti Checkout...");
//                         final navigatorContext = _scaffoldKey.currentContext ??
//                             context; // Use scaffold key context or fall back to widget context
//                         try {
//                           khalti.open(navigatorContext);
//                         } catch (e) {
//                           debugPrint(" Error opening Khalti: $e");
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                                 content:
//                                     Text("Failed to open Khalti payment: $e")),
//                           );
//                         }
//                       } else {
//                         debugPrint("❌ No pidx received for Khalti payment");
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               content: Text(
//                                   "Failed to initiate payment. No pidx received.")),
//                         );
//                       }
//                     }
//                   });
//                   Navigator.pop(dialogContext);
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text("Amount must be greater than 50.")),
//                   );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(255, 99, 2, 117),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//               ),
//               child: const Text("Pay with Khalti",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold)),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey, // Assign the global key to the Scaffold
//       appBar: AppBar(
//         title: const Text("Wallet"),
//         automaticallyImplyLeading: false,
//       ),
//       body: BlocBuilder<WalletBloc, WalletState>(
//         builder: (context, state) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildWalletBalance(state),
//                 const SizedBox(height: 20),
//                 _buildLoadWalletButton(),
//                 const SizedBox(height: 20),
//                 _buildTransactionSection(context),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   /// Wallet Balance Card
//   Widget _buildWalletBalance(WalletState state) {
//     double balance = 0;
//     if (state is WalletLoaded) {
//       balance = state.wallet.walletBalance;
//     }

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(32),
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: const [
//           BoxShadow(
//               color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text("Wallet Balance",
//                   style: TextStyle(color: Colors.white70, fontSize: 16)),
//               IconButton(
//                 icon: const Icon(FontAwesomeIcons.arrowRotateRight,
//                     color: Colors.white70),
//                 onPressed: () =>
//                     context.read<WalletBloc>().add(FetchWalletDetails()),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Text(
//             "Rs. ${balance.toStringAsFixed(2)}",
//             style: GoogleFonts.lato(
//                 fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           const SizedBox(height: 10),
//           Text(DateTime.now().toLocal().toString().split(' ')[0],
//               style: const TextStyle(color: Colors.white54, fontSize: 14)),
//         ],
//       ),
//     );
//   }

//   /// Load Wallet Button
//   Widget _buildLoadWalletButton() {
//     return Center(
//       child: TextButton.icon(
//         onPressed: _showLoadWalletDialog,
//         icon: const Icon(FontAwesomeIcons.plusCircle, color: Colors.green),
//         label: const Text("Load Wallet",
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
//         style: TextButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//               side: const BorderSide(color: Colors.green)),
//         ),
//       ),
//     );
//   }

//   /// Transaction History Section
//   Widget _buildTransactionSection(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text("Latest Transactions",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const TransactionHistoryScreen()),
//                 );
//               },
//               child: const Text("View All",
//                   style: TextStyle(color: Colors.blueAccent, fontSize: 16)),
//             )
//           ],
//         ),
//         // const SizedBox(height: 10),
//         // _buildSampleTransaction("Angga Big Park", "10 hours ago", "\$49,509",
//         //     FontAwesomeIcons.buildingColumns),
//         // _buildSampleTransaction("Top Up", "12 January 2025", "\$43,129,509",
//         //     FontAwesomeIcons.wallet,
//         //     color: Colors.green),
//         // _buildSampleTransaction("Angga Big Park", "10 hours ago", "\$49,509",
//         //     FontAwesomeIcons.buildingColumns),
//       ],
//     );
//   }

//   Widget _buildSampleTransaction(
//       String title, String time, String amount, IconData icon,
//       {Color color = Colors.blue}) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: const [
//           BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
//         ],
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: color.withOpacity(0.2),
//             child: Icon(icon, color: color),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 16)),
//                 Row(
//                   children: [
//                     const Icon(FontAwesomeIcons.clock,
//                         size: 12, color: Colors.grey),
//                     const SizedBox(width: 5),
//                     Text(time, style: TextStyle(color: Colors.grey.shade600)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Text(amount,
//               style:
//                   const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _subscription?.cancel(); // Clean up the stream subscription
//     super.dispose();
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';
import 'package:tutorme/features/wallet/domain/entity/transaction_entity.dart';
import 'package:tutorme/features/wallet/presentation/view/transaction_history_screen.dart';
import 'package:tutorme/features/wallet/presentation/view_model/bloc/wallet_bloc.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription? _subscription;
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _walletBalance = 0.0; // Store balance locally

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();

    // Fetch both wallet details and transaction history
    Future.microtask(() {
      context.read<WalletBloc>().add(FetchWalletDetails());
      context.read<WalletBloc>().add(FetchTransactionHistory());
    });
  }

  void _showLoadWalletDialog() {
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Add Money to Wallet",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Enter amount you wish to load",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Amount (Rs)",
                  prefixIcon: const Icon(FontAwesomeIcons.coins, size: 18),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFF5E17EB), width: 2),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
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

                  _subscription?.cancel();
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
                          publicKey: '59bc2858051d4983b53fd1b2033e9052',
                          pidx: pidx,
                          environment: Environment.test,
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                    "Payment Successful, Wallet Updated!"),
                                backgroundColor: Colors.green.shade700,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Payment event: $event - $description"),
                                  backgroundColor: Colors.deepOrange,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              );
                            }
                          },
                        );

                        debugPrint("🟢 Opening Khalti Checkout...");
                        final navigatorContext =
                            _scaffoldKey.currentContext ?? context;
                        try {
                          khalti.open(navigatorContext);
                        } catch (e) {
                          debugPrint(" Error opening Khalti: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Failed to open Khalti payment: $e"),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      } else {
                        debugPrint("❌ No pidx received for Khalti payment");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Failed to initiate payment. No pidx received."),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  });
                  Navigator.pop(dialogContext);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Amount must be greater than 50."),
                      backgroundColor: Colors.red.shade700,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5E17EB),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("My Wallet",
            style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              context.read<WalletBloc>().add(FetchWalletDetails());
              context.read<WalletBloc>().add(FetchTransactionHistory());
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _animation,
        child: BlocConsumer<WalletBloc, WalletState>(
          listener: (context, state) {
            // Update local balance when WalletLoaded is emitted
            if (state is WalletLoaded) {
              setState(() {
                _walletBalance = state.wallet.walletBalance;
              });
              debugPrint("Wallet Loaded: Balance updated to $_walletBalance");
            }
          },
          builder: (context, state) {
            // Extract transaction history
            List<TransactionEntity> transactions = [];
            if (state is TransactionHistoryLoaded) {
              transactions = state.transactions;
            }

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildWalletCard(_walletBalance),
                        const SizedBox(height: 24),
                        _buildActionButtons(),
                        const SizedBox(height: 32),
                        _buildTransactionHeader(context),
                      ],
                    ),
                  ),
                ),
                _buildTransactionList(transactions),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Modern Wallet Card resembling a credit card
  Widget _buildWalletCard(double balance) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF5E17EB), Color(0xFF9546C4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5E17EB).withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 10),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Card pattern overlay
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent
                      ],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.topRight,
                        radius: 1.5,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Card content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Card title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "tutorMe Wallet",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 12,
                  // ),

                  // Balance
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BALANCE (Rs.)",
                        style: GoogleFonts.spaceMono(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.7),
                          letterSpacing: 1.5,
                        ),
                      ),
                      // const SizedBox(height: 4),
                      Text(
                        balance.toStringAsFixed(2),
                        style: GoogleFonts.poppins(
                          fontSize: 64,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),

                  // Last updated
                  Text(
                    "As of: ${_formatDateYMD(DateTime.now())}",
                    style: GoogleFonts.roboto(
                      fontSize: 23,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateYMD(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  /// Action Buttons
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton(
          icon: FontAwesomeIcons.moneyBillTransfer,
          label: "Load Wallet",
          color: const Color(0xFF5E17EB),
          onTap: _showLoadWalletDialog,
        ),
        const SizedBox(width: 16),
        _buildActionButton(
          icon: FontAwesomeIcons.clockRotateLeft,
          label: "Transaction History",
          color: const Color(0xFF2196F3),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TransactionHistoryScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.3), width: 1),
            ),
            child: Column(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Transaction Header
  Widget _buildTransactionHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Recent Transactions",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TransactionHistoryScreen()),
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF5E17EB),
          ),
          child: const Row(
            children: [
              Text("View All", style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios, size: 12),
            ],
          ),
        ),
      ],
    );
  }

  /// Transaction List
  Widget _buildTransactionList(List<TransactionEntity> transactions) {
    if (transactions.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.receipt,
                  size: 48, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                "No transactions yet",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Load your wallet to get started",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Show only the latest 5 transactions
    final displayTransactions =
        transactions.length > 3 ? transactions.sublist(0, 3) : transactions;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 12,
              top: index == 0 ? 8 : 0,
            ),
            child: _buildTransactionCard(displayTransactions[index]),
          );
        },
        childCount: displayTransactions.length,
      ),
    );
  }

  Widget _buildTransactionCard(TransactionEntity transaction) {
    final bool isCredit = transaction.amount > 0;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isCredit ? Colors.green.shade50 : Colors.red.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            isCredit
                ? FontAwesomeIcons.moneyBillTransfer
                : FontAwesomeIcons.moneyBill1Wave,
            color: isCredit ? Colors.green.shade700 : Colors.red.shade700,
            size: 20,
          ),
        ),
        title: Text(
          transaction.paymentGateway,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          _formatDate(DateTime.parse(transaction.paymentDate.toString())),
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
        trailing: Text(
          "${isCredit ? '+' : '-'} Rs. ${transaction.amount.abs().toStringAsFixed(2)}",
          style: TextStyle(
            color: isCredit ? Colors.green.shade700 : Colors.red.shade700,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  /// Format date to readable format
  String _formatDate(DateTime date) {
    final now = DateTime.now();

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return "Today";
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      return "Yesterday";
    }

    final monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];

    return "${date.day} ${monthNames[date.month - 1]}, ${date.year}";
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _animationController.dispose();
    super.dispose();
  }
}
