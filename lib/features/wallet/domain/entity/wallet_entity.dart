import 'package:tutorme/features/wallet/domain/entity/transaction_entity.dart';

class WalletEntity {
  final double walletBalance;
  final List<TransactionEntity> transactions;

  const WalletEntity({
    required this.walletBalance,
    required this.transactions,
  });
}