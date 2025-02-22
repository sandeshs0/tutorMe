import 'package:tutorme/features/wallet/domain/entity/transaction_entity.dart';
import 'package:tutorme/features/wallet/domain/entity/wallet_entity.dart';

abstract interface class IWalletDataSource {
  Future<WalletEntity> getWalletDetails();
  Future<String> initiateTransaction({
    required double amount,
    required String paymentGateway,
  });
  Future<bool> verifyTransaction({
    required String pidx,
    required String transactionId,
  });
  Future<List<TransactionEntity>> getTransactionHistory();
}
