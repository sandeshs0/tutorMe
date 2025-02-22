class TransactionEntity {
  final String? transactionId;
  final String paymentDate;
  final String paymentGateway;
  final double amount;

  const TransactionEntity({
     this.transactionId,
    required this.paymentDate,
    required this.paymentGateway,
    required this.amount,
  });
}
