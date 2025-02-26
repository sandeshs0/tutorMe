import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tutorme/core/error/failure.dart';
import 'package:tutorme/features/wallet/domain/entity/transaction_entity.dart';
import 'package:tutorme/features/wallet/domain/entity/wallet_entity.dart';
import 'package:tutorme/features/wallet/domain/usecase/get_transaction_history.dart';
import 'package:tutorme/features/wallet/domain/usecase/get_wallet_details_usecase.dart';
import 'package:tutorme/features/wallet/domain/usecase/initiate_transaction_usecase.dart';
import 'package:tutorme/features/wallet/domain/usecase/verify_transaction_usecase.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetWalletDetailsUsecase _getWalletDetailsUseCase;
  final InitiateTransactionUsecase _initiateTransactionUseCase;
  final VerifyTransactionUsecase _verifyTransactionUseCase;
  final GetTransactionHistoryUsecase _getTransactionHistoryUseCase;

  WalletBloc({
    required GetWalletDetailsUsecase getWalletDetailsUseCase,
    required InitiateTransactionUsecase initiateTransactionUseCase,
    required VerifyTransactionUsecase verifyTransactionUseCase,
    required GetTransactionHistoryUsecase getTransactionHistoryUseCase,
  })  : _getWalletDetailsUseCase = getWalletDetailsUseCase,
        _initiateTransactionUseCase = initiateTransactionUseCase,
        _verifyTransactionUseCase = verifyTransactionUseCase,
        _getTransactionHistoryUseCase = getTransactionHistoryUseCase,
        super(WalletInitial()) {
    on<FetchWalletDetails>(_onFetchWalletDetails);
    on<InitiateTransaction>(_onInitiateTransaction);
    on<VerifyTransaction>(_onVerifyTransaction);
    on<FetchTransactionHistory>(_onFetchTransactionHistory);
  }

  /// 🔹 Fetch Wallet Details
  Future<void> _onFetchWalletDetails(
      FetchWalletDetails event, Emitter<WalletState> emit) async {
    emit(WalletLoading()); // Show loading before API call

    final result = await _getWalletDetailsUseCase();

    result.fold(
      (failure) => emit(WalletError(message: _mapFailureToMessage(failure))),
      (wallet) {
        debugPrint("Wallet Data Emitted: Rs. ${wallet.walletBalance}");
        emit(WalletLoaded(wallet: wallet)); // ✅ Ensure correct state is emitted
      },
    );
  }

  /// 🔹 Initiate Transaction
  Future<void> _onInitiateTransaction(
      InitiateTransaction event, Emitter<WalletState> emit) async {
    emit(WalletLoading());

    final result = await _initiateTransactionUseCase(
      amount: event.amount,
      paymentGateway: event.paymentGateway,
    );

    // result.fold(
    //   (failure) => emit(WalletError(message: _mapFailureToMessage(failure))),
    //   (paymentUrl) => emit(TransactionInitiated(paymentUrl: paymentUrl)),
    // );
    result.fold(
      (failure) {
        debugPrint(
            "❌ Transaction Initiation Failed: ${_mapFailureToMessage(failure)}");
        emit(WalletError(message: _mapFailureToMessage(failure)));
      },
      (transaction) {
        // ✅ `pidx` received, now use KhaltiCheckout
        debugPrint("✅ Transaction Successful, pidx: ${transaction.pidx}");

        emit(TransactionInitiated(transaction: transaction));
      },
    );
  }

  /// 🔹 Verify Transaction
  Future<void> _onVerifyTransaction(
      VerifyTransaction event, Emitter<WalletState> emit) async {
    emit(WalletLoading());

    final result = await _verifyTransactionUseCase(
      pidx: event.pidx,
      transactionId: event.transactionId,
    );

    result.fold(
        (failure) => emit(WalletError(message: _mapFailureToMessage(failure))),
        (_) {
      emit(TransactionVerified());
      add(FetchWalletDetails()); // ✅ Refresh Wallet Balance after payment
    });
  }

  /// 🔹 Fetch Transaction History
  Future<void> _onFetchTransactionHistory(
      FetchTransactionHistory event, Emitter<WalletState> emit) async {
    emit(TransactionHistoryLoading()); // 🔹 Show loader only for history

    final result = await _getTransactionHistoryUseCase();

    result.fold(
      (failure) => emit(WalletError(message: _mapFailureToMessage(failure))),
      (transactions) {
        if (transactions.isEmpty) {
          emit(const WalletError(message: "No transactions available."));
        } else {
          emit(TransactionHistoryLoaded(transactions: transactions));
        }
      },
    );
  }

  /// 🔹 Map API failures to readable messages
  String _mapFailureToMessage(Failure failure) {
    if (failure is ApiFailure) {
      return failure.message;
    } else {
      return "An unexpected error occurred.";
    }
  }
}
