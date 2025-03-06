import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/wallet/data/data_source/wallet_data_source.dart';
import 'package:tutorme/features/wallet/data/dto/initiate_transaction_dto.dart';
import 'package:tutorme/features/wallet/domain/entity/transaction_entity.dart';
import 'package:tutorme/features/wallet/domain/entity/wallet_entity.dart';
import 'package:tutorme/features/wallet/domain/repository/wallet_repository.dart';

class WalletRemoteRepository implements IWalletRepository {
  final IWalletDataSource _walletDataSource;

  WalletRemoteRepository({required IWalletDataSource walletDataSource})
      : _walletDataSource = walletDataSource;

  @override
  Future<Either<Failure, WalletEntity>> getWalletDetails() async {
    try {
      final wallet = await _walletDataSource.getWalletDetails();
      return Right(wallet);
    } catch (e) {
      return Left(ApiFailure(message: "Failed to fetch wallet details: $e"));
    }
  }

  @override
  Future<Either<Failure, TransactionEntity>> initiateTransaction({
    required double amount,
    required String paymentGateway,
  }) async {
    try {
      final InitiateTransactionDTO transactionDTO =
          await _walletDataSource.initiateTransaction(
        amount: amount,
        paymentGateway: paymentGateway,
      );
      final transactionEntity = TransactionEntity(
        transactionId: transactionDTO.transactionId,
        pidx: transactionDTO.pidx,
        paymentUrl: transactionDTO.paymentUrl,
        paymentDate: DateTime.now().toIso8601String(),
        paymentGateway: paymentGateway,
        amount: amount,
      );

      debugPrint("🔵 Received pidx: ${transactionDTO.pidx}");
      debugPrint("🔵 Received paymentUrl: ${transactionDTO.paymentUrl}");
      debugPrint("🔵 Received transactionId: ${transactionDTO.transactionId}");

      return Right(transactionEntity);
    } catch (e) {
      return Left(ApiFailure(message: "Failed to initiate transaction: $e"));
    }
  }

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
