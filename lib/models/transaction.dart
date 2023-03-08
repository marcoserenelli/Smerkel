class Transaction {
  final double amount;
  final String title;
  final String description;
  final DateTime date;

  Transaction({
    required this.amount,
    required this.title,
    required this.description,
    required this.date,
  });
}
