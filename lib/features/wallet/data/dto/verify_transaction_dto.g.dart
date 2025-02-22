// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_transaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyTransactionDTO _$VerifyTransactionDTOFromJson(
        Map<String, dynamic> json) =>
    VerifyTransactionDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$VerifyTransactionDTOToJson(
        VerifyTransactionDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
