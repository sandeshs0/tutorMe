import 'package:dartz/dartz.dart';
import 'package:tutorme/app/usecase/usecase.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';
import 'package:tutorme/features/tutors/domain/repository/tutor_repository.dart';

class GetAllTutorsUsecase
    implements UsecaseWithParams<List<TutorEntity>, GetTutorsParams> {
  final ITutorRepository tutorRepository;

  GetAllTutorsUsecase({required this.tutorRepository});

  @override
  Future<Either<Failure, List<TutorEntity>>> call(GetTutorsParams params) async {
    return await tutorRepository.getAllTutors(page: params.page, limit: params.limit);
  }
}

class GetTutorsParams {
  final int page;
  final int limit;
  const GetTutorsParams({required this.page, required this.limit});
}

