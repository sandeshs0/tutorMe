part of 'wallet_bloc.dart';

sealed class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

// Initial state
class WalletInitial extends WalletState {}

// Wallet loading state
class WalletLoading extends WalletState {}

// 🔹 Transaction history specific loading state
class TransactionHistoryLoading extends WalletState {}

// Wallet details fetched successfully
class WalletLoaded extends WalletState {
  final WalletEntity wallet;

  const WalletLoaded({required this.wallet});

  @override
  List<Object?> get props => [wallet];
}

// Transaction initiation success
class TransactionInitiated extends WalletState {
  // final String paymentUrl;
  final String transaction;
  // const TransactionInitiated({required this.paymentUrl});
  const TransactionInitiated({required this.transaction});

  @override
  List<Object?> get props => [transaction];
  // List<Object?> get props => [paymentUrl];
}

// Transaction verification success
class TransactionVerified extends WalletState {}

// Transaction history fetched successfully
class TransactionHistoryLoaded extends WalletState {
  final List<TransactionEntity> transactions;

  const TransactionHistoryLoaded({required this.transactions});

  @override
  List<Object?> get props => [transactions];
}

// Error state
class WalletError extends WalletState {
  final String message;

  const WalletError({required this.message});

  @override
  List<Object?> get props => [message];
}
