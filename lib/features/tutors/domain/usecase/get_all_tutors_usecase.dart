import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tutorme/app/usecase/usecase.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/core/common/internet_checker/connectivity_service.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';
import 'package:tutorme/features/tutors/domain/repository/tutor_repository.dart';

class GetAllTutorsUsecase
    implements UsecaseWithParams<List<TutorEntity>, GetTutorsParams> {
  final ITutorRepository remoteRepository;
  final ITutorRepository localRepository;
  final ConnectivityService connectivityService;

  GetAllTutorsUsecase(
      {required this.remoteRepository,
      required this.localRepository,
      required this.connectivityService});

  @override
  Future<Either<Failure, List<TutorEntity>>> call(
      GetTutorsParams params) async {
    try {
      final isConnected = await connectivityService.isConnected();

      if (isConnected) {
        final remoteResult = await remoteRepository.getAllTutors(
          page: params.page,
          limit: params.limit,
        );
        return remoteResult.fold(
          (failure) => Left(failure),
          (tutors) async {
            await localRepository
                .saveTutors(tutors);
            return Right(tutors);
          },
        );
      } else {
        final localResult = await localRepository.getAllTutors(
          page: params.page,
          limit: params.limit,
        );
        return localResult.fold(
          (failure) => Left(failure),
          (tutors) => Right(tutors.isEmpty ? [] : tutors),
        );
      }
    } catch (e) {
      return Left(ApiFailure(message: "Failed to fetch tutors: $e"));
    }
  }
}

class GetTutorsParams extends Equatable {
  final int page;
  final int limit;
  const GetTutorsParams({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}
