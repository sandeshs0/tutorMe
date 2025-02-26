import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/wallet/domain/entity/transaction_entity.dart';
import 'package:tutorme/features/wallet/domain/entity/wallet_entity.dart';

abstract class IWalletRepository {
  Future<Either<Failure, WalletEntity>> getWalletDetails();
  Future<Either<Failure, TransactionEntity>> initiateTransaction({
    required double amount,
    required String paymentGateway,
  });
  Future<Either<Failure, bool>> verifyTransaction({
    required String pidx,
    required String transactionId,
  });
  Future<Either<Failure, List<TransactionEntity>>> getTransactionHistory();
}
