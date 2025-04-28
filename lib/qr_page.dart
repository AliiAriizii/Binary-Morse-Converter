import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodePage extends StatelessWidget {
  final String data =
      "https://www.example.com";

  const QRCodePage({super.key}); // داده‌ای که می‌خواهید در QR Code قرار بگیرد

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate QR Code'),
      ),
      body: Center(
        child: QrImageView(
          data: data, // داده‌ای که در QR کد قرار می‌گیرد
          size: 200.0, // اندازه QR Code
        ),
      ),
    );
  }
}
