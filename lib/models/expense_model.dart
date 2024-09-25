class Expense {
  final double amount;
  final String paymentCategory;
  final String category;
  final DateTime date;
  final String comments;

  Expense({
    required this.amount,
    required this.paymentCategory,
    required this.category,
    required this.date,
    required this.comments,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'paymentCategory': paymentCategory,
      'category': category,
      'date': date.toIso8601String(),
      'comments' : comments,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      amount: json['amount'] as double,
      paymentCategory: json['paymentCategory'] as String,
      category: json['category'] as String,
      date: DateTime.parse(json['date'] as String),
      comments: json['comments'] as String,
    );
  }
}