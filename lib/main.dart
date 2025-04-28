import 'package:flutter/material.dart';
import 'upload_page.dart';
import 'qr_page.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Text Converter',
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => const WelcomePage(),
        '/binary': (context) => const BinaryPage(),
        '/morse': (context) => const MorsePage(),
        '/file-upload': (context) => const FileUploadPage(), // مسیر صفحه آپلود
        '/qr-code': (context) => const QRCodePage(), // مسیر صفحه QR Code
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
              const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.pushNamed(
              //         context, '/qr-code'); // هدایت به صفحه QR Code
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.white,
              //     foregroundColor: Colors.blue,
              //     padding:
              //         const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              //   ),
              //   child: const Text('Generate QR Code'),
              // ),
            ],
          ),
        ),
      ),
      // اضافه کردن دکمه علامت تعجب
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showInfoDialog(context);
        },
        backgroundColor: const Color.fromARGB(255, 21, 36, 53),
        child: const Icon(Icons.help_outline),
      ),
    );
  }

  // دیالوگ توضیحات و ایمیل
  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("About Me"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Hello, I'm Ali Arizi  the developer of this app ."),
              Text("If you have any questions, feel free to contact me."),
              SizedBox(height: 10),
              Text("Email: arizi3553@gmail.com"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
