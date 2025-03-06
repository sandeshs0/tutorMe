import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/wallet/domain/entity/transaction_entity.dart';

part 'transaction_dto.g.dart';

@JsonSerializable()
class TransactionDTO {
  @JsonKey(name: '_id')
  final String transactionId;
  final double amount;
  final String paymentGateway;
  final String paymentDate;

  const TransactionDTO({
    required this.transactionId,
    required this.amount,
    required this.paymentGateway,
    required this.paymentDate,
  });

  factory TransactionDTO.fromJson(Map<String, dynamic> json) =>
      _$TransactionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDTOToJson(this);

  TransactionEntity toEntity() {
    return TransactionEntity(
      transactionId: transactionId,
      amount: amount,
      paymentGateway: paymentGateway,
      paymentDate: paymentDate,
    );
  }

  factory TransactionDTO.fromEntity(TransactionEntity entity) {
    return TransactionDTO(
      transactionId: entity.transactionId ?? "",
      amount: entity.amount,
      paymentGateway: entity.paymentGateway,
      paymentDate: entity.paymentDate,
    );
  }
}
