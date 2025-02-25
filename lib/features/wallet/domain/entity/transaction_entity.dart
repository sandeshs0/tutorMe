class TransactionEntity {
  final String? transactionId;
  final String? pidx;
  final String paymentDate;
  final String? paymentUrl;
  final String paymentGateway;
  final double amount;

  const TransactionEntity({
     this.transactionId,
     this.pidx,
     this.paymentUrl,

    required this.paymentDate,
    required this.paymentGateway,
    required this.amount,
  });
}
