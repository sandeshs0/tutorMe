// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletApiModel _$WalletApiModelFromJson(Map<String, dynamic> json) =>
    WalletApiModel(
      walletBalance: (json['walletBalance'] as num).toDouble(),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => TransactionApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WalletApiModelToJson(WalletApiModel instance) =>
    <String, dynamic>{
      'walletBalance': instance.walletBalance,
      'transactions': instance.transactions,
    };
