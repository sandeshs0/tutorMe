import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/wallet/data/model/transaction_api_model.dart';
import 'package:tutorme/features/wallet/domain/entity/wallet_entity.dart';

part 'wallet_api_model.g.dart';

@JsonSerializable()
class WalletApiModel extends Equatable {
  final double walletBalance;
  final List<TransactionApiModel> transactions;

  const WalletApiModel({
    required this.walletBalance,
    required this.transactions,
  });

  factory WalletApiModel.fromJson(Map<String, dynamic> json) =>
      _$WalletApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletApiModelToJson(this);

  WalletEntity toEntity() {
    return WalletEntity(
      walletBalance: walletBalance,
      transactions: transactions.map((t) => t.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [walletBalance, transactions];
}
