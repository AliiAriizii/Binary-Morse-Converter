import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MorsePage extends StatefulWidget {
  const MorsePage({Key? key}) : super(key: key);

  @override
  _MorsePageState createState() => _MorsePageState();
}

class _MorsePageState extends State<MorsePage> {
  String inputText = '';
  String morseText = '';
  List<String> history = [];

  String convertToMorse(String text) {
    const morseCode = {
      'A': '.-',
      'B': '-...',
      'C': '-.-.',
      'D': '-..',
      'E': '.',
      'F': '..-.',
      'G': '--.',
      'H': '....',
      'I': '..',
      'J': '.---',
      'K': '-.-',
      'L': '.-..',
      'M': '--',
      'N': '-.',
      'O': '---',
      'P': '.--.',
      'Q': '--.-',
      'R': '.-.',
      'S': '...',
      'T': '-',
      'U': '..-',
      'V': '...-',
      'W': '.--',
      'X': '-..-',
      'Y': '-.--',
      'Z': '--..',
      '1': '.----',
      '2': '..---',
      '3': '...--',
      '4': '....-',
      '5': '.....',
      '6': '-....',
      '7': '--...',
      '8': '---..',
      '9': '----.',
      '0': '-----',
      ' ': ' ',
    };
    return text.toUpperCase().split('').map((char) {
      return morseCode[char] ?? '';
    }).join(' ');
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard!')),
    );
  }

  void addToHistory(String text) {
    setState(() {
      history.insert(0, text); // Add new conversion to the top
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Morse Code Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter text to convert',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  inputText = value;
                  morseText = convertToMorse(inputText);
                });
              },
            ),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                morseText,
                key: ValueKey<String>(morseText),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: morseText.isNotEmpty
                  ? () {
                      copyToClipboard(morseText);
                      addToHistory(morseText);
                    }
                  : null,
              child: const Text('Copy Morse Code'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
