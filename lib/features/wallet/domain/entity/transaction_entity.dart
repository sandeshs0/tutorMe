class TransactionEntity {
  final String? transactionId;
  final String? pidx;
  final String paymentDate;
  final String paymentGateway;
  final double amount;

  const TransactionEntity({
     this.transactionId,
     this.pidx,
    required this.paymentDate,
    required this.paymentGateway,
    required this.amount,
  });
}
