import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting date

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
  // String _paymentCategory = '';
  String? _paymentCategory; // Initially set to null
  String _category = '';
  late DateTime _selectedDate = DateTime.now();
  String _comments = '';

  void _saveExpense() async {
    if (_formKey.currentState?.validate() ?? false) {

      if (_paymentCategory == null) {
        // Show error if payment category is not selected
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a payment category')),
        );
        return; // Exit early if validation fails
      }

      _formKey.currentState?.save();
      final expense = Expense(
        amount: _amount,
        // paymentCategory: _paymentCategory,
        paymentCategory: _paymentCategory ?? 'Need', // Should not be null at this point
        category: _category,
        date: _selectedDate ?? DateTime.now(), // Using selected date or current date
        comments: _comments,
      );

      // Logging the expense details locally
      if (kDebugMode) {
        print('Expense Details: Amount: $_amount, Payment Category: $_paymentCategory, Category: $_category, Date: ${expense.date}, Comments: $_comments');
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
        _paymentCategory = '';
        _category = '';
        _comments = '';
      });

    }
  }


  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _paymentCategory = null; // Set initial state to null
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
          child: ListView(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Amount is mandatory';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _amount = double.parse(value!);
                },
              ),
              const SizedBox(height: 16.0),
              const Text('Choose Payment Category', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['Need', 'Wants', 'Savings'].map((categoryPayment) =>
                    FilledButton.tonal(
                      onPressed: () {
                        setState(() {
                          _paymentCategory = categoryPayment;
                        });
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: _paymentCategory == categoryPayment
                            ? Colors.blueGrey
                            : Colors.grey[300],
                      ),
                      child: Text(categoryPayment),
                    ),
                ).toList(),
              ),
              // Validation message
              if (_paymentCategory == null)
                const Text(
                  'Payment Category is mandatory',
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _category.isNotEmpty ? _category : null,
                decoration: const InputDecoration(
                  labelText: 'Category',
                ),
                hint: const Text('Select a category'),
                items: ['Rent', 'Food', 'Transport', 'Entertainment'].map(( category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: ( value) {
                  setState(() {
                    _category = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Category is mandatory';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ListTile(
                title: Text('Date: ${DateFormat.yMd().format(_selectedDate)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Comments',
                ),
                onSaved: (value) {
                  _comments = value ?? '';
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