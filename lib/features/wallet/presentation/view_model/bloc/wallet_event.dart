part of 'wallet_bloc.dart';

sealed class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object?> get props => [];
}

// Fetch wallet balance
class FetchWalletDetails extends WalletEvent {}

// Initiate a transaction
class InitiateTransaction extends WalletEvent {
  final double amount;
  final String paymentGateway;

  const InitiateTransaction({required this.amount, required this.paymentGateway});

  @override
  List<Object?> get props => [amount, paymentGateway];
}

// Verify transaction
class VerifyTransaction extends WalletEvent {
  final String pidx;
  final String transactionId;

  const VerifyTransaction({required this.pidx, required this.transactionId});

  @override
  List<Object?> get props => [pidx, transactionId];
}

// Fetch transaction history
class FetchTransactionHistory extends WalletEvent {}
