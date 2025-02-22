import 'package:dio/dio.dart';
import 'package:tutorme/app/constants/api_endpoints.dart';
import 'package:tutorme/app/shared_prefs/token_shared_prefs.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/wallet/data/data_source/wallet_data_source.dart';
import 'package:tutorme/features/wallet/data/dto/get_wallet_details_dto.dart';
import 'package:tutorme/features/wallet/data/dto/transaction_dto.dart';
import 'package:tutorme/features/wallet/domain/entity/transaction_entity.dart';
import 'package:tutorme/features/wallet/domain/entity/wallet_entity.dart';

class WalletRemoteDataSource implements IWalletDataSource {
  final Dio _dio;
  final TokenSharedPrefs _tokenSharedPrefs;

  WalletRemoteDataSource({
    required Dio dio,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _dio = dio,
        _tokenSharedPrefs = tokenSharedPrefs;

  /// **🔹 Fetch Wallet Balance**
  @override
  Future<WalletEntity> getWalletDetails() async {
    try {
      // ✅ Get Token from Shared Preferences
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold((failure) => null, (token) => token);

      if (token == null || token.isEmpty) {
        throw const ApiFailure(message: "Authentication token missing.");
      }

      // ✅ API Call
      final response = await _dio.get(
        ApiEndpoints.getWalletBalance,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        final data = GetWalletDetailsDTO.fromJson(response.data);
        return data.toEntity();
      } else {
        throw const ApiFailure(message: "Failed to fetch wallet details.");
      }
    } on DioException catch (e) {
      throw ApiFailure(message: e.response?.data['message'] ?? "API Error");
    }
  }

  /// **🔹 Initiate a Payment Transaction**
  @override
  Future<String> initiateTransaction({
    required double amount,
    required String paymentGateway,
  }) async {
    try {
      // ✅ Get Token
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold((failure) => null, (token) => token);

      if (token == null || token.isEmpty) {
        throw const ApiFailure(message: "Authentication token missing.");
      }

      // ✅ API Call
      final response = await _dio.post(
        ApiEndpoints.initiateTransaction,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: {
          "amount": amount,
          "paymentGateway": paymentGateway,
        },
      );

      if (response.statusCode == 201) {
        return response.data["payment_url"];
      } else {
        throw const ApiFailure(message: "Failed to initiate transaction.");
      }
    } on DioException catch (e) {
      throw ApiFailure(message: e.response?.data['message'] ?? "API Error");
    }
  }

  /// **🔹 Verify a Payment Transaction**
  @override
  Future<bool> verifyTransaction({
    required String pidx,
    required String transactionId,
  }) async {
    try {
      // ✅ Get Token
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold((failure) => null, (token) => token);

      if (token == null || token.isEmpty) {
        throw const ApiFailure(message: "Authentication token missing.");
      }

      // ✅ API Call
      final response = await _dio.post(
        ApiEndpoints.verifyTransaction,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: {
          "pidx": pidx,
          "transaction_id": transactionId,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw const ApiFailure(message: "Transaction verification failed.");
      }
    } on DioException catch (e) {
      throw ApiFailure(message: e.response?.data['message'] ?? "API Error");
    }
  }

  /// **🔹 Fetch Transaction History**
  @override
  Future<List<TransactionEntity>> getTransactionHistory() async {
    try {
      // ✅ Get Token
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold((failure) => null, (token) => token);

      if (token == null || token.isEmpty) {
        throw const ApiFailure(message: "Authentication token missing.");
      }

      // ✅ API Call
      final response = await _dio.get(
        ApiEndpoints.getTransactions,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        final List<TransactionDTO> transactions =
            (response.data["transactions"] as List)
                .map((json) => TransactionDTO.fromJson(json))
                .toList();
        return transactions.map((dto) => dto.toEntity()).toList();
      } else {
        throw const ApiFailure(message: "Failed to fetch transactions.");
      }
    } on DioException catch (e) {
      throw ApiFailure(message: e.response?.data['message'] ?? "API Error");
    }
  }
}
