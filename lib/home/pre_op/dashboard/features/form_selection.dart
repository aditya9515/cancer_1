import 'package:flutter/material.dart';
import 'package:cancer/home/post_op/dashboard/features/LC13Form.dart';
import 'package:cancer/home/post_op/dashboard/features/OES18Form.dart';
import 'package:cancer/home/post_op/dashboard/features/OV28Form.dart';
import 'package:cancer/home/post_op/dashboard/features/STO22Form.dart';

class FormSelectionScreen extends StatefulWidget {
  @override
  _FormSelectionScreenState createState() => _FormSelectionScreenState();
}

class _FormSelectionScreenState extends State<FormSelectionScreen> {
  String? selectedForm; 
  final Map<String, Widget> formRoutes = {
    "Lung Cancer (LC13)": LC13Form(),
    "Esophageal Cancer (OES18)": OES18Form(),
    "Ovarian Cancer (OV28)": OV28Form(),
    "Stomach Cancer (STO22)": STO22Form(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Cancer Form",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Container(
        color: Colors.orange.shade50,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select a cancer form:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.orange, width: 1),
                ),
              ),
              isExpanded: true,
              value: selectedForm,
              hint: Text("Choose a form"),
              items: formRoutes.keys.map((String form) {
                return DropdownMenuItem<String>(
                  value: form,
                  child: Text(form),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedForm = newValue;
                });
              },
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedForm != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => formRoutes[selectedForm]!,
                      ),
                    );
                  } else {
                    // Show an alert if no form is selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please select a form to proceed.")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.orange.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Go to Selected Form",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
