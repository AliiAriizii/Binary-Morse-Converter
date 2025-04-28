import 'package:flutter/material.dart';
import 'binary_page.dart';
import 'morse_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Converter',
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => const WelcomePage(),
        '/binary': (context) => const BinaryPage(),
        '/morse': (context) => const MorsePage(),
      },
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final List<List<Color>> _colorPairs = [
    [Colors.blue.shade200, Colors.blue.shade800],
    [Colors.teal.shade300, Colors.teal.shade700],
    [Colors.indigo.shade200, Colors.indigo.shade700],
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startColorTransition();
  }

  void _startColorTransition() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _colorPairs.length;
      });
      _startColorTransition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 3),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _colorPairs[_currentIndex],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Text Converter',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/binary');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text('Go to Binary Converter'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/morse');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 90, 87, 87),
                  foregroundColor: const Color.fromARGB(255, 223, 224, 224),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text('Go to Morse Converter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
