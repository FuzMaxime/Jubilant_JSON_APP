import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:jubilant_json_app/features/employees/models/employee_model.dart';
import 'package:jubilant_json_app/features/employees/pages/camera_page.dart';
import 'package:path/path.dart';

class CNIPage extends StatefulWidget {
  final CameraDescription camera;
  final Employee employee;

  const CNIPage({super.key, required this.camera, required this.employee});

  @override
  State<CNIPage> createState() => _CNIPageState();
}

class _CNIPageState extends State<CNIPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((error) {
      print("Erreur lors de l'initialisation de la caméra : $error");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TakePictureScreen(
      camera: widget.camera,
    );
  }

  Future<String?> cropImage(String imagePath) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        aspectRatio: CropAspectRatio(ratioX: 4, ratioY: 3),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Rogner l\'image',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Rogner l\'image',
          ),
        ],
      );

      return croppedFile?.path;
    } catch (e) {
      print("Erreur lors du rognage de l'image : $e");
      return null;
    }
  }

  Future<Map<String, String>> extractTextFromImage(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = TextRecognizer();

    try {
      final recognizedText = await textRecognizer.processImage(inputImage);
      textRecognizer.close();

      final extractedInfo = <String, String>{};
      for (final block in recognizedText.blocks) {
        for (final line in block.lines) {
          final text = line.text;

          if (text.contains('Nom'))
            extractedInfo['Nom'] = text.split(':').last.trim();
          if (text.contains('Prénom'))
            extractedInfo['Prénom'] = text.split(':').last.trim();
          if (text.contains('Date de naissance'))
            extractedInfo['Date de naissance'] = text.split(':').last.trim();
          if (text.contains('Date de fin de validité'))
            extractedInfo['Date de fin de validité'] =
                text.split(':').last.trim();
          if (text.contains('Numéro de la CNI'))
            extractedInfo['Numéro de la CNI'] = text.split(':').last.trim();
        }
      }

      return extractedInfo;
    } catch (e) {
      print('Erreur lors de la reconnaissance de texte : $e');
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
      appBar: AppBar(title: const Text('Informations extraites')),
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
