import 'package:flutter/material.dart';

class AddExpenseButton extends StatelessWidget {
  const AddExpenseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0), // space from the bottom
      child: SizedBox(
        height: 80.0, // Set the button height
        width: 80.0,  // Set the button width
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_expense');
          },
          backgroundColor: Colors.lightBlueAccent,
          shape: const CircleBorder(), // Ensure the shape is circular
          child: const Icon(
            Icons.add,
            size: 70.0, // Larger icon size
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}