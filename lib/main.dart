import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/',
      routes: {
        '/': (context) => const PrivateScreen(),
        '/second': (context) => const SecondScreen(),
      },
    );
  }
}


class HomeScreen extends StatefulWidget {
  final String name;
  const HomeScreen({super.key, required this.name});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Create Animation for fade effect
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the fade-out animation
    Future.delayed(const Duration(milliseconds: 100), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/second');
                  },
                  child: const Text('Second Screen'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/private');
                  },
                  child: const Text('Private Screen'),
                ),
              ],
            ),
          ),
          // Positioned widget for the message
          Positioned(
            top: 16,
            right: 16,
            child: FadeTransition(
              opacity: _animation,
              child: Text(
                'Welcome back, ${widget.name}!',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secondary Page'),
      ),
      body: const Center(
        child: Text('Welcome to the second screen!'),
      ),
    );
  }
}

class PrivateScreen extends StatelessWidget {

  const PrivateScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                // Navigate to Screen2 when the button is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  HomeScreen(name:email)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}