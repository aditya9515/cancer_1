
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlcoholSmokingFeature extends StatefulWidget {
  String phonenumber = "";
  AlcoholSmokingFeature(String Phonenumber){
    phonenumber = Phonenumber;
  }

  @override
  _AlcoholSmokingFeatureState createState() => _AlcoholSmokingFeatureState();
}

class _AlcoholSmokingFeatureState extends State<AlcoholSmokingFeature> {
  DateTime? lastAlcoholDate;
  DateTime? lastSmokingDate;

  // Format date for display
  String formatDate(DateTime? date) {
    if (date == null) return 'Not Set';
    return DateFormat.yMMMd().format(date);
  }

  Future<void> saveSmokeData(String phoneNumber, DateTime lastSmoking) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference alcoholSmokeRef = firestore
      .collection('Users')
      .doc(phoneNumber)
      .collection('alcohol_smoke')
      .doc('activity_log'); // Single document for smoking and drinking

  await alcoholSmokeRef.set({
    'last_smoking': lastSmoking,
  });
}
  Future<void> saveAlcoholData(String phoneNumber, DateTime lastDrinking) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference alcoholSmokeRef = firestore
      .collection('Users')
      .doc(phoneNumber)
      .collection('alcohol_smoke')
      .doc('activity_log'); // Single document for smoking and drinking

  await alcoholSmokeRef.set({
    'last_drinking': lastDrinking,
  });
}


  // Pick a date from date picker
  Future<void> _selectDate(BuildContext context, String type) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        if (type == 'alcohol') {
          lastAlcoholDate = pickedDate;
          saveSmokeData(widget.phonenumber,lastAlcoholDate!);
        } else if (type == 'smoking') {
          lastSmokingDate = pickedDate;
          saveSmokeData(widget.phonenumber,lastSmokingDate!);
        }
      });
    }
  }


  Widget _buildDateCard(String title, String date, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3), 
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 40, color: Color.fromARGB(255, 245, 132, 26)),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.edit, color: Color.fromARGB(255, 245, 132, 26)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Alcohol & Smoking Dates',
          style: TextStyle(color: const Color.fromARGB(221, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 132, 26),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color.fromARGB(221, 255, 255, 255)),
          onPressed: () {
            Navigator.of(context).pop();  // Go back to previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDateCard(
              'Last Alcohol Consumption',
              formatDate(lastAlcoholDate),
              Icons.local_drink,
              () => _selectDate(context, 'alcohol'),
            ),
            _buildDateCard(
              'Last Smoking',
              formatDate(lastSmokingDate),
              Icons.smoking_rooms,
              () => _selectDate(context, 'smoking'),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 245, 132, 26),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              ),
              onPressed: () {
                // Add functionality for saving or proceeding
              },
              child: Text(
                'Save Changes',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
