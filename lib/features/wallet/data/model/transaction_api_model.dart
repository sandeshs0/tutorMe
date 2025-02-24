import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/wallet/domain/entity/transaction_entity.dart';

part 'transaction_api_model.g.dart';

@JsonSerializable()
class TransactionApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String transactionId;
  final double amount;
  final String paymentGateway;
  final String paymentDate;

  const TransactionApiModel({
    required this.transactionId,
    required this.amount,
    required this.paymentGateway,
    required this.paymentDate,
  });

  /// **Convert from JSON**
  factory TransactionApiModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionApiModelFromJson(json);

  /// **Convert to JSON**
  Map<String, dynamic> toJson() => _$TransactionApiModelToJson(this);

  /// **Convert to Domain Entity**
  TransactionEntity toEntity() {
    return TransactionEntity(
      transactionId: transactionId,
      amount: amount,
      paymentGateway: paymentGateway,
      paymentDate: paymentDate,
    );
  }

  @override
  List<Object?> get props => [transactionId, amount, paymentGateway, paymentDate];
}
