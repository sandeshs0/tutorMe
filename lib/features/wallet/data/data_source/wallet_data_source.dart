import 'package:tutorme/features/wallet/data/dto/initiate_transaction_dto.dart';
import 'package:tutorme/features/wallet/domain/entity/transaction_entity.dart';
import 'package:tutorme/features/wallet/domain/entity/wallet_entity.dart';

abstract interface class IWalletDataSource {
  Future<WalletEntity> getWalletDetails();
  Future<InitiateTransactionDTO> initiateTransaction({
    required double amount,
    required String paymentGateway,
  });
  Future<bool> verifyTransaction({
    required String pidx,
    required String transactionId,
  });
  Future<List<TransactionEntity>> getTransactionHistory();
}
