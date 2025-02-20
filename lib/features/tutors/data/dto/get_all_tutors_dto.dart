import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/tutors/data/model/tutor_api_model.dart';

part 'get_all_tutors_dto.g.dart';

@JsonSerializable()
class GetAllTutorsDTO {
  final String message;
  final List<TutorApiModel> tutors;
  final PaginationDTO pagination;

  GetAllTutorsDTO({
    required this.message,
    required this.tutors,
    required this.pagination,
  });

  factory GetAllTutorsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllTutorsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllTutorsDTOToJson(this);
}

@JsonSerializable()
class PaginationDTO {
  final int currentPage;
  final int totalPages;
  final int totalTutors;

  PaginationDTO({
    required this.currentPage,
    required this.totalPages,
    required this.totalTutors,
  });

  factory PaginationDTO.fromJson(Map<String, dynamic> json) =>
      _$PaginationDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationDTOToJson(this);
}
