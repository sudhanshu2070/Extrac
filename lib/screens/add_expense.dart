import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/services/expense_service.dart';
import '/models/expense_model.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  AddExpensePageState createState() => AddExpensePageState();
}

class AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  double _amount = 0.0;
  String _paymentCategory = 'A';
  String _category = '';

  void _saveExpense() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final expense = Expense(
        amount: _amount,
        paymentCategory: _paymentCategory,
        category: _category,
        date: DateTime.now(),
      );

      // Logging the expense details locally
      if (kDebugMode) {
        print('Expense Details: Amount: $_amount, Payment Category: $_paymentCategory, Category: $_category, Date: ${expense.date}');
      }

      //await ExpenseAPI.saveExpense(expense);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Expense saved successfully!'),
          ),
        );
      }

      //Clearing the form after saving
      _formKey.currentState?.reset();
      setState(() {
        _amount = 0.0;
        _paymentCategory = 'A';
        _category = '';
      });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
                onSaved: (value) {
                  _amount = double.parse(value!);
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _paymentCategory,
                decoration: const InputDecoration(
                  labelText: 'Payment Category',
                ),
                items: ['A', 'B', 'C'].map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _paymentCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Category',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
                onSaved: (value) {
                  _category = value!;
                },
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _saveExpense,
                child: const Text('Save Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}