import 'package:flutter/material.dart';

class NextVisitScreen extends StatelessWidget {
  final String patientId;

  const NextVisitScreen({required this.patientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Visit'),
        backgroundColor: Colors.orange.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patient ID: $patientId',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Next Visit: 2024-11-10'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement Calendar Integration
              },
              child: Text('View Calendar'),
            ),
          ],
        ),
      ),
    );
  }
}
