import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/wallet/data/model/transaction_api_model.dart';
import 'package:tutorme/features/wallet/domain/entity/wallet_entity.dart';

part 'get_wallet_details_dto.g.dart';

@JsonSerializable()
class GetWalletDetailsDTO {
  final bool success;
  final double walletBalance;
  final List<TransactionApiModel> transactions;

  GetWalletDetailsDTO({
    required this.success,
    required this.walletBalance,
    required this.transactions,
  });

  factory GetWalletDetailsDTO.fromJson(Map<String, dynamic> json) {
    return GetWalletDetailsDTO(
      success: json['success'] ?? false,
      walletBalance:
          (json['walletBalance'] as num).toDouble(), 
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((txn) => TransactionApiModel.fromJson(txn))
              .toList() ??
          [], 
    );
  }

  Map<String, dynamic> toJson() => _$GetWalletDetailsDTOToJson(this);

  WalletEntity toEntity() {
    return WalletEntity(
      walletBalance: walletBalance,
      transactions: transactions.map((txn) => txn.toEntity()).toList(),
    );
  }
}
