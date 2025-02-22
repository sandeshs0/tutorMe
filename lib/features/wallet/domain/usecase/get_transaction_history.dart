import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/wallet/domain/entity/transaction_entity.dart';
import 'package:tutorme/features/wallet/domain/repository/wallet_repository.dart';

class GetTransactionHistoryUsecase {
  final IWalletRepository repository;

  GetTransactionHistoryUsecase({required this.repository});

  Future<Either<Failure, List<TransactionEntity>>> call() async {
    return await repository.getTransactionHistory();
  }
}