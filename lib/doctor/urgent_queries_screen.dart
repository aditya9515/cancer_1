import 'package:flutter/material.dart';

class UrgentQueriesScreen extends StatefulWidget {
  final String patientId;

  const UrgentQueriesScreen({required this.patientId});

  @override
  _UrgentQueriesScreenState createState() => _UrgentQueriesScreenState();
}

class _UrgentQueriesScreenState extends State<UrgentQueriesScreen> {
  bool isHighPriority = true; // Example state to simulate urgent query alerts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Urgent Queries'),
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
            ListTile(
              title: Text(
                'High priority query! Repeat alerts every hour.',
                style: TextStyle(color: Colors.red.shade400),
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isHighPriority = false; // Mark query as addressed
                  });
                },
                child: Text('Mark as Addressed'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
