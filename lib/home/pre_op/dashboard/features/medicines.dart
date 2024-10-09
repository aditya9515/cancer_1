import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart'; // For storing images locally
import 'package:path/path.dart'; // To handle file paths

class PrescriptionScreen extends StatefulWidget {
  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> _prescriptions = []; // List to hold uploaded prescriptions

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        File savedImage = await _saveImage(File(pickedFile.path));
        if (!mounted) return;

        setState(() {
          _prescriptions.add(savedImage);
        });
      }
    } catch (e) {
      print('Image selection error: $e');
    }
  }

  Future<File> _saveImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = basename(image.path);
    final savedImage = await image.copy('${directory.path}/$fileName');
    return savedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Prescriptions',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 241, 150, 30),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 250, 250, 250),), // Custom back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 243, 150, 28), // Orange accent
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              onPressed: () => _pickImage(ImageSource.camera),
              child: Text(
                'Take a Picture of Prescription',
                style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 255, 255, 255)),
                
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 250, 156, 33), // Orange accent
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              onPressed: () => _pickImage(ImageSource.gallery),
              child: Text(
                'Upload Prescription from Gallery',
                style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _prescriptions.isEmpty
                  ? Center(child: Text('No prescriptions uploaded.', style: TextStyle(fontSize: 18),))
                  : ListView.builder(
                      itemCount: _prescriptions.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _prescriptions[index],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text('Prescription ${index + 1}'),
                            onTap: () => _viewPrescription(_prescriptions[index]),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _viewPrescription(File prescription) {
    if (!mounted) return;

    Navigator.of(context as BuildContext).push(
      MaterialPageRoute(
        builder: (_) => ViewPrescriptionScreen(prescription: prescription),
      ),
    );
  }
}

class ViewPrescriptionScreen extends StatelessWidget {
  final File prescription;

  ViewPrescriptionScreen({required this.prescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Prescription'),
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
      ),
      body: Center(
        child: Image.file(prescription),
      ),
    );
  }
}
