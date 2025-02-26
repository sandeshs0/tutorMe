import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/wallet/domain/entity/transaction_entity.dart';
import 'package:tutorme/features/wallet/domain/repository/wallet_repository.dart';

class InitiateTransactionUsecase {
  final IWalletRepository repository;

  InitiateTransactionUsecase({required this.repository});

  Future<Either<Failure, TransactionEntity>> call({
    required double amount,
    required String paymentGateway,
  }) async {
    return await repository.initiateTransaction(
      amount: amount,
      paymentGateway: paymentGateway,
    );
  }
}
