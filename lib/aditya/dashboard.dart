import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser; // Get the current user

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _auth.signOut(); // Sign out the user
              Navigator.pushReplacementNamed(context, '/'); // Redirect to login
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome doctor, ${user?.phoneNumber ?? "doctor"}!",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to another page or feature
                Navigator.pushNamed(context, '/someOtherPage'); // Change to your page
              },
              child: Text("Go to Another Feature"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Example action
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Feature Coming Soon!"),
                      content: Text("This feature will be available soon."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text("Learn More"),
            ),
          ],
        ),
      ),
    );
  }
}
