import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SignupScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: const Color(0xFF2E2F45), // Deep Navy Gray for the AppBar
        foregroundColor: Colors.white, // Change the color of the back button to white
        titleTextStyle: TextStyle(
          // color: Colors.white, // Set title color to white for better visibility
          fontSize: 21.5, // You can adjust the font size as needed
          fontWeight: FontWeight.normal, // Optional: make the title bold
          foreground: Paint()
            ..shader = ui.Gradient.linear(
              const Offset(0, 35),
              const Offset(160, 50),
              <Color>[
                Colors.white,
                Colors.blueGrey,
              ],
            ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create an Account',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            _buildUsernameField(),
            const SizedBox(height: 16),
            _buildPasswordField(),
            const SizedBox(height: 16),
            _buildMobileField(),
            const SizedBox(height: 16),
            _buildEmailField(),
            const SizedBox(height: 24),
            _buildSignupButton(context),
            const SizedBox(height: 16),
            _buildLoginLink(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextField(
      controller: _usernameController,
      decoration: const InputDecoration(
        labelText: 'Username',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildMobileField() {
    return TextField(
      controller: _mobileController,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: 'Mobile Number',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle signup logic here
        // Example: Navigator.pushNamed(context, '/home');
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 36),
      ),
      child: const Text('Sign Up'),
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('Already have an account? Login'),
    );
  }
}
