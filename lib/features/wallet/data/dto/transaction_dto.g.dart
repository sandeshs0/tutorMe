// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDTO _$TransactionDTOFromJson(Map<String, dynamic> json) =>
    TransactionDTO(
      transactionId: json['_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      paymentGateway: json['paymentGateway'] as String,
      paymentDate: json['paymentDate'] as String,
    );

Map<String, dynamic> _$TransactionDTOToJson(TransactionDTO instance) =>
    <String, dynamic>{
      '_id': instance.transactionId,
      'amount': instance.amount,
      'paymentGateway': instance.paymentGateway,
      'paymentDate': instance.paymentDate,
    };
