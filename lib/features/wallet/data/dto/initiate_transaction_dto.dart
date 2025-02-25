import 'package:json_annotation/json_annotation.dart';

part 'initiate_transaction_dto.g.dart';

@JsonSerializable()
class InitiateTransactionDTO {
  final bool success;
  final String pidx;
  final String paymentUrl;
  final String transactionId;

  InitiateTransactionDTO({
    required this.success,
    required this.pidx,
    required this.paymentUrl,
    required this.transactionId,
  });

  // factory InitiateTransactionDTO.fromJson(Map<String, dynamic> json) =>
  //     _$InitiateTransactionDTOFromJson(json);

  factory InitiateTransactionDTO.fromJson(Map<String, dynamic> json) {
    // ✅ Handle null values safely
    return InitiateTransactionDTO(
      success: true,
      pidx: json['pidx'] ?? "", // ✅ Use empty string if null
      paymentUrl: json['payment_url'] ?? "",
      transactionId: json['transactionId'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => _$InitiateTransactionDTOToJson(this);
}
