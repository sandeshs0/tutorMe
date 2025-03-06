part of 'wallet_bloc.dart';

sealed class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class TransactionHistoryLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final WalletEntity wallet;

  const WalletLoaded({required this.wallet});

  @override
  List<Object?> get props => [wallet];
}
class TransactionInitiated extends WalletState {
  final TransactionEntity transaction;

  const TransactionInitiated({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}


class TransactionVerified extends WalletState {}

class TransactionHistoryLoaded extends WalletState {
  final List<TransactionEntity> transactions;

  const TransactionHistoryLoaded({required this.transactions});

  @override
  List<Object?> get props => [transactions];
}

class WalletError extends WalletState {
  final String message;

  const WalletError({required this.message});

  @override
  List<Object?> get props => [message];
}
