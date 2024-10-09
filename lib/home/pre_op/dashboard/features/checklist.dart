import 'package:flutter/material.dart';

class ChecklistPage extends StatefulWidget {
  ChecklistPage(String phoneNumber);

  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  // Checklist items and their states
  List<Map<String, dynamic>> checklistItems = [
    {'title': 'Booking of the room', 'isChecked': false},
    {'title': 'ESI/insurance application', 'isChecked': false},
    {'title': 'Medications to be brought along', 'isChecked': false},
    {'title': 'Incentive spirometer to be carried along', 'isChecked': false},
    {'title': 'CT / MRI outside CD’s to be brought along (if applicable)', 'isChecked': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      appBar: AppBar(
        title: Text(
          'Pre-Surgery Checklist',
          style: TextStyle(color: const Color.fromARGB(221, 255, 255, 255), fontSize: 20, ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 159, 33), // Orange accent for the AppBar
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 250, 250, 250),), // Custom back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        elevation: 1, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: ListView.builder(
          itemCount: checklistItems.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0), // Space between cards
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), 
              ),
              elevation: 3, // Slight shadow to lift the card off the background
              child: CheckboxListTile(
                activeColor: Colors.orangeAccent, 
                title: Text(
                  checklistItems[index]['title'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: checklistItems[index]['isChecked']
                        ? Colors.orangeAccent
                        : Colors.black87, // Change color when checked
                  ),
                ),
                value: checklistItems[index]['isChecked'],
                onChanged: (bool? value) {
                  setState(() {
                    checklistItems[index]['isChecked'] = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading, // Checkbox on the left
                checkColor: Colors.white, // White checkmark
              ),
            );
          },
        ),
      ),
    );
  }
}
