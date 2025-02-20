import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/tutors/data/model/tutor_api_model.dart';

part 'get_tutor_by_username_dto.g.dart';

@JsonSerializable()
class GetTutorByUsernameDTO {
  final String message;
  final TutorApiModel tutor;

  GetTutorByUsernameDTO({
    required this.message,
    required this.tutor,
  });

  factory GetTutorByUsernameDTO.fromJson(Map<String, dynamic> json) =>
      _$GetTutorByUsernameDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetTutorByUsernameDTOToJson(this);
}
