import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/wallet/data/data_source/wallet_data_source.dart';
import 'package:tutorme/features/wallet/domain/entity/transaction_entity.dart';
import 'package:tutorme/features/wallet/domain/entity/wallet_entity.dart';
import 'package:tutorme/features/wallet/domain/repository/wallet_repository.dart';

class WalletRemoteRepository implements IWalletRepository {
  final IWalletDataSource _walletDataSource;

  WalletRemoteRepository({required IWalletDataSource walletDataSource})
      : _walletDataSource = walletDataSource;

  /// 🔹 Fetch Wallet Details
  @override
  Future<Either<Failure, WalletEntity>> getWalletDetails() async {
    try {
      final wallet = await _walletDataSource.getWalletDetails();
      return Right(wallet);
    } catch (e) {
      return Left(ApiFailure(message: "Failed to fetch wallet details: $e"));
    }
  }

  /// 🔹 Initiate a Transaction
  @override
  Future<Either<Failure, String>> initiateTransaction({
    required double amount,
    required String paymentGateway,
  }) async {
    try {
      final paymentUrl = await _walletDataSource.initiateTransaction(
        amount: amount,
        paymentGateway: paymentGateway,
      );
      return Right(paymentUrl);
    } catch (e) {
      return Left(ApiFailure(message: "Failed to initiate transaction: $e"));
    }
  }

  /// 🔹 Verify a Transaction
  @override
  Future<Either<Failure, bool>> verifyTransaction({
    required String pidx,
    required String transactionId,
  }) async {
    try {
      final isVerified = await _walletDataSource.verifyTransaction(
        pidx: pidx,
        transactionId: transactionId,
      );
      return Right(isVerified);
    } catch (e) {
      return Left(ApiFailure(message: "Transaction verification failed: $e"));
    }
  }

  /// 🔹 Fetch Transaction History
  @override
  Future<Either<Failure, List<TransactionEntity>>>
      getTransactionHistory() async {
    try {
      final transactions = await _walletDataSource.getTransactionHistory();
      return Right(transactions);
    } catch (e) {
      return Left(ApiFailure(message: "Failed to fetch transactions: $e"));
    }
  }
}
