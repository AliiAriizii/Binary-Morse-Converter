import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileUploadPage extends StatefulWidget {
  const FileUploadPage({super.key});

  @override
  _FileUploadPageState createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  File? _selectedFile;
  final ImagePicker _picker = ImagePicker();

  // برای انتخاب فایل
  Future<void> _pickFile() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final File file = File('$path/${pickedFile.name}');
      await file.writeAsBytes(await pickedFile.readAsBytes());
      setState(() {
        _selectedFile = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedFile == null
                ? const Text('No file selected.')
                : Image.file(_selectedFile!),
            ElevatedButton(
              onPressed: _pickFile,
              child: const Text('Pick a file from gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
