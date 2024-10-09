import 'package:flutter/material.dart';

class WoundManagementScreen extends StatefulWidget {
  final String patientId;

  const WoundManagementScreen({required this.patientId});

  @override
  _WoundManagementScreenState createState() => _WoundManagementScreenState();
}

class _WoundManagementScreenState extends State<WoundManagementScreen> {
  List<String> woundImages = []; // Example list to store wound images

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wound Management'),
        backgroundColor: Colors.orange.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Patient ID: ${widget.patientId}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            woundImages.isNotEmpty
                ? Wrap(
                    spacing: 10,
                    children: woundImages.map((imagePath) {
                      return Image.asset(
                        imagePath,
                        height: 50,
                        width: 50,
                      );
                    }).toList(),
                  )
                : Text('No wound images uploaded yet.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to upload wound image
                setState(() {
                  woundImages.add('assets/sample_wound_image.png'); // Example image
                });
              },
              child: Text('Upload Wound Image'),
            ),
          ],
        ),
      ),
    );
  }
}
