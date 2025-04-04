import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prendre une photo')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();

            if (!context.mounted) return;

            if (image.path != null) {
              final extractedText = await extractTextFromImage(image.path);

              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayExtractedInfoScreen(
                    imagePath: image.path,
                    extractedText: extractedText,
                  ),
                ),
              );
            }
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Future<Map<String, String>> extractTextFromImage(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = TextRecognizer();

    try {
      final recognizedText = await textRecognizer.processImage(inputImage);
      textRecognizer.close();

      // Extract relevant info from the recognized text
      final extractedInfo = <String, String>{};
      for (final block in recognizedText.blocks) {
        for (final line in block.lines) {
          final text = line.text;

          if (text.contains('Nom'))
            extractedInfo['Nom'] = text.split(':').last.trim();
          if (text.contains('Prénom'))
            extractedInfo['Prénom'] = text.split(':').last.trim();
          if (text.contains('Né'))
            extractedInfo['Date de naissance'] = text.split(':').last.trim();
        }
      }

      return extractedInfo;
    } catch (e) {
      print('Error during text recognition: $e');
      return {};
    }
  }
}

class DisplayExtractedInfoScreen extends StatelessWidget {
  final String imagePath;
  final Map<String, String> extractedText;

  const DisplayExtractedInfoScreen({
    super.key,
    required this.imagePath,
    required this.extractedText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Extracted Information')),
      body: Column(
        children: [
          Image.file(File(imagePath)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: extractedText.length,
              itemBuilder: (context, index) {
                final key = extractedText.keys.elementAt(index);
                final value = extractedText[key];
                return ListTile(
                  title: Text('$key'),
                  subtitle: Text('$value'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
