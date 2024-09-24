import 'dart:convert';
import 'dart:io';

import '/models/expense_model.dart';

class ExpenseAPI {
  static Future<void> saveExpense(Expense expense) async {
    final expensesFile = File('expenses.json');
    List<Expense> expenses = [];

    if (await expensesFile.exists()) {
      final expensesJson = await expensesFile.readAsString();
      final expensesData = json.decode(expensesJson) as List<dynamic>;
      expenses = expensesData.map((e) => Expense.fromJson(e as Map<String, dynamic>)).toList();
    }

    expenses.add(expense);
    final expensesJson = json.encode(expenses.map((e) => e.toJson()).toList());
    await expensesFile.writeAsString(expensesJson);
  }
}