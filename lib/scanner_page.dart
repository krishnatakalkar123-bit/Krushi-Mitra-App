import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScannerPage {
  static Future<void> openScanner(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );

      if (photo == null) return;

      // फोटो मिळाल्यावर रिझल्ट दाखवणारी विंडो (Bottom Sheet)
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => Container(
          padding: const EdgeInsets.all(20),
          height: 300,
          child: Column(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 60),
              const SizedBox(height: 15),
              const Text("फोटो यशस्वीरीत्या घेतला!", 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const Divider(),
              const Text("AI आता पिकांवरील रोगाची आणि औषधांची माहिती शोधत आहे...", 
                textAlign: TextAlign.center),
              const SizedBox(height: 20),
              const CircularProgressIndicator(color: Colors.green),
            ],
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}