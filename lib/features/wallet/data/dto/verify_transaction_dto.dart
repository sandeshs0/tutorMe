import 'package:json_annotation/json_annotation.dart';

part 'verify_transaction_dto.g.dart';

@JsonSerializable()
class VerifyTransactionDTO {
  final bool success;
  final String message;

  VerifyTransactionDTO({
    required this.success,
    required this.message,
  });

  factory VerifyTransactionDTO.fromJson(Map<String, dynamic> json) =>
      _$VerifyTransactionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyTransactionDTOToJson(this);
}
