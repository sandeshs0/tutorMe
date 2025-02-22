// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_wallet_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWalletDetailsDTO _$GetWalletDetailsDTOFromJson(Map<String, dynamic> json) =>
    GetWalletDetailsDTO(
      success: json['success'] as bool,
      walletBalance: (json['walletBalance'] as num).toDouble(),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => TransactionApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetWalletDetailsDTOToJson(
        GetWalletDetailsDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'walletBalance': instance.walletBalance,
      'transactions': instance.transactions,
    };
