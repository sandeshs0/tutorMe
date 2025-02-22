import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/features/wallet/domain/entity/transaction_entity.dart';
import 'package:tutorme/features/wallet/presentation/view_model/bloc/wallet_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch wallet balance & transaction history
    context.read<WalletBloc>().add(FetchWalletDetails());
    context.read<WalletBloc>().add(FetchTransactionHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wallet"),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<WalletBloc, WalletState>(
        listener: (context, state) {
          if (state is TransactionInitiated) {
            // ✅ Open Khalti payment link in web browser
            _openPaymentUrl(state.paymentUrl);
          } else if (state is TransactionVerified) {
            // ✅ Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Transaction Verified! Wallet Updated."),
                backgroundColor: Colors.green,
              ),
            );
            // ✅ Refresh wallet balance & transactions
            context.read<WalletBloc>().add(FetchWalletDetails());
            context.read<WalletBloc>().add(FetchTransactionHistory());
          } else if (state is WalletError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          debugPrint(
              "Wallet Screen State: ${state.runtimeType}"); // ✅ Print state

          if (state is WalletLoaded) {
            debugPrint("Wallet Balance UI: Rs. ${state.wallet.walletBalance}");
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildWalletBalance(state),
                const SizedBox(height: 20),
                _buildAddMoneyButton(),
                const SizedBox(height: 30),
                _buildTransactionHistory(state),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 🔹 Wallet Balance Card
  Widget _buildWalletBalance(WalletState state) {
    if (state is WalletLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is WalletLoaded) {
      debugPrint("Updating UI with balance: Rs. ${state.wallet.walletBalance}");

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Text("Wallet Balance",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(
              "Rs. ${state.wallet.walletBalance.toStringAsFixed(2)}",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ],
        ),
      );
    } else {
      debugPrint("Wallet Balance UI: Failed to load balance."); // ✅ Debug Print
      return const Center(child: Text("Failed to load wallet balance."));
    }
  }

  /// 🔹 "Add Money" Button
  Widget _buildAddMoneyButton() {
    return ElevatedButton.icon(
      onPressed: _showAddMoneyDialog,
      icon: const Icon(Icons.add_circle, size: 22),
      label: const Text("Add Money"),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  /// 🔹 Transaction History Section
  Widget _buildTransactionHistory(WalletState state) {
    if (state is WalletLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is TransactionHistoryLoaded) {
      final transactions = state.transactions;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Transaction History",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          transactions.isEmpty
              ? const Center(child: Text("No transactions found."))
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    return _buildTransactionTile(transactions[index]);
                  },
                ),
        ],
      );
    } else {
      return const Center(child: Text("Failed to load transactions."));
    }
  }

  /// 🔹 Transaction Tile
  Widget _buildTransactionTile(TransactionEntity transaction) {
    return ListTile(
      leading: const Icon(Icons.payment, color: Colors.green, size: 32),
      title: Text("Rs. ${transaction.amount.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      subtitle: Text(transaction.paymentGateway),
      trailing: Text(
        _formatDate(DateTime.parse(transaction.paymentDate
            .toString())), // ✅ Convert String to DateTime
        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
      ),
    );
  }

  /// 🔹 "Add Money" Dialog
  void _showAddMoneyDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Money"),
          content: TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Enter Amount"),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(_amountController.text) ?? 0;
                if (amount > 0) {
                  _initiateTransaction(amount);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Please enter a valid amount.")),
                  );
                }
              },
              child: const Text("Proceed"),
            ),
          ],
        );
      },
    );
  }

  /// 🔹 Initiate Transaction
  void _initiateTransaction(double amount) {
    context.read<WalletBloc>().add(InitiateTransaction(
          amount: amount,
          paymentGateway: "Khalti",
        ));
  }

  /// 🔹 Open Khalti Payment URL
  Future<void> _openPaymentUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to open payment link.")),
      );
    }
  }

  /// 🔹 Format Transaction Date
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
  }
}
