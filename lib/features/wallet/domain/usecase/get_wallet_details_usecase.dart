import 'package:dartz/dartz.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/wallet/domain/entity/wallet_entity.dart';
import 'package:tutorme/features/wallet/domain/repository/wallet_repository.dart';

class GetWalletDetailsUsecase {
  final IWalletRepository repository;

  GetWalletDetailsUsecase({required this.repository});

  Future<Either<Failure, WalletEntity>> call() async {
    return await repository.getWalletDetails();
  }
}