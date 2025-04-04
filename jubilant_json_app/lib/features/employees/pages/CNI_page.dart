import 'dart:io';

import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:jubilant_json_app/core/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:jubilant_json_app/core/widgets/navbar_widget.dart';
import 'package:jubilant_json_app/features/employees/models/employee_model.dart';

class CNIPage extends StatefulWidget {
  final Employee employee;

  const CNIPage({super.key, required this.employee});

  @override
  State<CNIPage> createState() => _CNIPageState();
}

class _CNIPageState extends State<CNIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainHeader(
              title: "Employé",
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'CNI de ${widget.employee.first_name} ${widget.employee.last_name}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.camera_alt),
            label: const Text("Scanner la CNI"),
            onPressed: () async {
              await scanCNI();
            },
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }

  Future<XFile?> takePicture() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    final controller = CameraController(camera, ResolutionPreset.high);
    await controller.initialize();

    final image = await controller.takePicture();
    await controller.dispose();

    return image;
  }

  Future<File?> cropImage(String imagePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [CropAspectRatioPreset.ratio4x3],
      uiSettings: [
        AndroidUiSettings(toolbarTitle: 'Rogner la CNI'),
      ],
    );

    return croppedFile != null ? File(croppedFile.path) : null;
  }

  Future<String> recognizeText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String scannedText = recognizedText.text;
    await textRecognizer.close();
    return scannedText;
  }

  Future<void> scanCNI() async {
    final picture = await takePicture();
    if (picture == null) return;

    final cropped = await cropImage(picture.path);
    if (cropped == null) return;

    final result = await recognizeText(cropped);
    print("Texte reconnu : $result");
  }
}
