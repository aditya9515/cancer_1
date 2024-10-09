import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'patient_detail_screen.dart';

class PatientsScreen extends StatefulWidget {
  @override
  _PatientsScreenState createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  final List<Map<String, String>> patients = [];

  @override
  void initState() {
    super.initState();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("users").get().then((querySnapshot) {
      for (var snapshotdoc in querySnapshot.docs) {
        firestore
            .collection("users")
            .doc(snapshotdoc.id.toString())
            .get()
            .then((DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          setState(() {
            if (data['role'] == "patients") {
              patients.add({
                'phoneNumber': snapshotdoc.id.toString(),
                'surgeryDate': data['surgeryDate'].toDate().toString()
              });
            }
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.orange.shade100,
                child: Icon(
                  Icons.person,
                  color: Colors.orange.shade600,
                  size: 28,
                ),
              ),
              title: Text(
                'Phone Number: ${patients[index]['phoneNumber']}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              subtitle: Text(
                'Surgery Date: ${patients[index]['surgeryDate']}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Colors.orange.shade600),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientDetailScreen(
                      patientPhoneNumber: patients[index]['phoneNumber']!,
                      surgeryDate: patients[index]['surgeryDate']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
