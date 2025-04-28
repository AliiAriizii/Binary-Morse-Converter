import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BinaryPage extends StatefulWidget {
  const BinaryPage({Key? key}) : super(key: key);

  @override
  _BinaryPageState createState() => _BinaryPageState();
}

class _BinaryPageState extends State<BinaryPage> {
  String inputText = '';
  String binaryText = '';
  List<String> history = [];

  String convertToBinary(String text) {
    return text.runes
        .map((int rune) => rune.toRadixString(2).padLeft(8, '0'))
        .join(' ');
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
        title: const Text('Binary Converter'),
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
                  binaryText = convertToBinary(inputText);
                });
              },
            ),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                binaryText,
                key: ValueKey<String>(binaryText),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: binaryText.isNotEmpty
                  ? () {
                      copyToClipboard(binaryText);
                      addToHistory(binaryText);
                    }
                  : null,
              child: const Text('Copy Binary Text'),
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
