import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/session/data/model/session_api_model.dart';

part 'get_my_sessions_dto.g.dart';

@JsonSerializable()
class GetStudentSessionsDTO {
  final bool success;
  final List<SessionApiModel> sessions;

  GetStudentSessionsDTO({
    required this.success,
    required this.sessions,
  });

  factory GetStudentSessionsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetStudentSessionsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetStudentSessionsDTOToJson(this);
}
