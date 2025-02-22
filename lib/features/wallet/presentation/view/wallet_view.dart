import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutorme/features/wallet/presentation/view/transaction_history_screen.dart';
import 'package:tutorme/features/wallet/presentation/view_model/bloc/wallet_bloc.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(FetchWalletDetails());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("My Wallet",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.arrowRotateRight),
            onPressed: () =>
                context.read<WalletBloc>().add(FetchWalletDetails()),
          )
        ],
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
      padding: const EdgeInsets.all(24),
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
          Text(
            "\$${balance.toStringAsFixed(2)}",
            style: GoogleFonts.lato(
                fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Wallet Balance",
                      style: TextStyle(color: Colors.white70, fontSize: 16)),
                  Text("**** **** 1234",
                      style: TextStyle(color: Colors.white54, fontSize: 14)),
                ],
              ),
              Icon(FontAwesomeIcons.wallet, color: Colors.white70, size: 28),
            ],
          ),
        ],
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

  /// Sample Transaction Tile
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
}
