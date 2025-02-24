// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionApiModel _$TransactionApiModelFromJson(Map<String, dynamic> json) =>
    TransactionApiModel(
      transactionId: json['_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      paymentGateway: json['paymentGateway'] as String,
      paymentDate: json['paymentDate'] as String,
    );

Map<String, dynamic> _$TransactionApiModelToJson(
        TransactionApiModel instance) =>
    <String, dynamic>{
      '_id': instance.transactionId,
      'amount': instance.amount,
      'paymentGateway': instance.paymentGateway,
      'paymentDate': instance.paymentDate,
    };
