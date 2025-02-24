import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/wallet/domain/repository/wallet_repository.dart';

class VerifyTransactionUsecase {
  final IWalletRepository repository;

  VerifyTransactionUsecase({required this.repository});

  Future<Either<Failure, bool>> call({
    required String pidx,
    required String transactionId,
  }) async {
    return await repository.verifyTransaction(
      pidx: pidx,
      transactionId: transactionId,
    );
  }
}