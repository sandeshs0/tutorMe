part of 'wallet_bloc.dart';

sealed class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object?> get props => [];
}

class FetchWalletDetails extends WalletEvent {}

class InitiateTransaction extends WalletEvent {
  final double amount;
  final String paymentGateway;

  const InitiateTransaction(
      {required this.amount, required this.paymentGateway});

  @override
  List<Object?> get props => [amount, paymentGateway];
}

class TransactionInitiatedEvent extends WalletEvent {
  final TransactionEntity
      transaction; 
  const TransactionInitiatedEvent({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

class VerifyTransaction extends WalletEvent {
  final String pidx;
  final String transactionId;

  const VerifyTransaction({required this.pidx, required this.transactionId});

  @override
  List<Object?> get props => [pidx, transactionId];
}

class FetchTransactionHistory extends WalletEvent {}
