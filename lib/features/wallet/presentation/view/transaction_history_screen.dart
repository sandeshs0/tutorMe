import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/features/wallet/domain/entity/transaction_entity.dart';
import 'package:tutorme/features/wallet/presentation/view_model/bloc/wallet_bloc.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WalletBloc>().add(FetchTransactionHistory()); // ✅ API call
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transaction History")),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is TransactionHistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionHistoryLoaded) {
            return _buildTransactionList(state.transactions);
          } else if (state is WalletError) {
            return Center(
                child: Text(state.message,
                    style: const TextStyle(color: Colors.red, fontSize: 16)));
          } else {
            return const Center(
                child: Text("No transactions found.",
                    style: TextStyle(fontSize: 16)));
          }
        },
      ),
    );
  }

  /// 🔹 Transaction List
  Widget _buildTransactionList(List<TransactionEntity> transactions) {
    if (transactions.isEmpty) {
      return const Center(
          child: Text("No transactions available.",
              style: TextStyle(fontSize: 16)));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        return _buildTransactionTile(transactions[index]);
      },
    );
  }

  /// 🔹 Transaction Tile
  Widget _buildTransactionTile(TransactionEntity transaction) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(Icons.payment,
            color: transaction.amount > 0 ? Colors.green : Colors.red,
            size: 32),
        title: Text(
          "Rs. ${transaction.amount.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          transaction.paymentGateway,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        trailing: Text(
          _formatDate(DateTime.parse(transaction.paymentDate.toString())),
          style: const TextStyle(color: Colors.blue, fontSize: 14),
        ),
      ),
    );
  }

  /// 🔹 Format Transaction Date
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
  }
}
