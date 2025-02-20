import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tutorme/app/usecase/usecase.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';
import 'package:tutorme/features/tutors/domain/repository/tutor_repository.dart';

class GetTutorByUsernameParams extends Equatable {
  final String username;

  const GetTutorByUsernameParams({required this.username});

  @override
  List<Object?> get props => [username];
}

class GetTutorByUsernameUsecase
    implements UsecaseWithParams<TutorEntity, GetTutorByUsernameParams> {
  final ITutorRepository tutorRepository;

  GetTutorByUsernameUsecase({required this.tutorRepository});

  @override
  Future<Either<Failure, TutorEntity>> call(
      GetTutorByUsernameParams params) async {
    return await tutorRepository.getTutorByUsername(params.username);
  }
}
