// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_transaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitiateTransactionDTO _$InitiateTransactionDTOFromJson(
        Map<String, dynamic> json) =>
    InitiateTransactionDTO(
      success: json['success'] as bool,
      pidx: json['pidx'] as String,
      paymentUrl: json['paymentUrl'] as String,
      transactionId: json['transactionId'] as String,
    );

Map<String, dynamic> _$InitiateTransactionDTOToJson(
        InitiateTransactionDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'pidx': instance.pidx,
      'paymentUrl': instance.paymentUrl,
      'transactionId': instance.transactionId,
    };
