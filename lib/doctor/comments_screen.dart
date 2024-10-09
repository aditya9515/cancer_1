import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  final String patientId;

  const CommentsScreen({required this.patientId});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  String doctorComments = ""; // Holds the comments for the patient

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor/Nurse Comments'),
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
            doctorComments.isNotEmpty
                ? Text('Comment: $doctorComments')
                : Text('No comments yet.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showAddCommentDialog(context);
              },
              child: Text('Add Comment'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCommentDialog(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Comment'),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(hintText: 'Enter comment'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  doctorComments = commentController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
