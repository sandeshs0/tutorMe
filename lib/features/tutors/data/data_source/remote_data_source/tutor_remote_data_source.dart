import 'package:dio/dio.dart';
import 'package:tutorme/app/constants/api_endpoints.dart';
import 'package:tutorme/features/tutors/data/data_source/tutor_data_source.dart';
import 'package:tutorme/features/tutors/data/dto/get_all_tutors_dto.dart';
import 'package:tutorme/features/tutors/data/dto/get_tutor_by_username_dto.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';

class TutorRemoteDataSource implements ITutorDataSource {
  final Dio _dio;
  

  TutorRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<List<TutorEntity>> getAllTutors({int page = 1, int limit = 10}) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.getAllTutors,
        queryParameters: {"page": page, "limit": limit},
      );

      if (response.statusCode == 200) {
        final data = GetAllTutorsDTO.fromJson(response.data);
        return data.tutors.map((tutor) => tutor.toEntity()).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  @override
  Future<TutorEntity> getTutorByUsername(String username)async {
    try{
      final response= await _dio.get(
        "${ApiEndpoints.getTutorProfile}/$username",
        );

      if (response.statusCode==200){
        final data = GetTutorByUsernameDTO.fromJson(response.data);
        return data.tutor.toEntity();
      }else{
        throw Exception(response.statusMessage);
      }
    } on DioException catch(e){
      throw Exception(e.response?.data['message']??e.message);
    }catch (e){
      throw Exception("Something went wrong (datasource): $e");
    }
  }
}
