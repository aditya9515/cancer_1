import 'package:cancer/aditya/firestore_date.dart';
import 'package:flutter/material.dart';
// For date formatting


class HomeScreen extends StatefulWidget {
  final String userId;

  HomeScreen({required this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  DateTime? surgeryDate;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkSurgeryDate();
  }

  // Fetch surgery date and navigate based on the comparison
  Future<void> _checkSurgeryDate() async {
    surgeryDate = await _firestoreService.getSurgeryDate(widget.userId);
    
    if (surgeryDate != null) {
      DateTime today = DateTime.now();

      if (surgeryDate!.isAfter(today)) {
        // Navigate to Pre-Surgery Dashboard if the surgery is in the future
        Navigator.pushReplacementNamed(context, '/pre-surgery');
      } else {
        // Navigate to Post-Surgery Dashboard if the surgery is in the past
        Navigator.pushReplacementNamed(context, '/post-surgery');
      }
    } else {
      // Handle error (e.g., no surgery date found)
      setState(() {
        isLoading = false;
      });
      print("Surgery date not found.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checking Surgery Date..."),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Text(
                "Error: Could not find surgery date.",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
      ),
    );
  }
}
