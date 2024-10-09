
import 'package:cloud_firestore/cloud_firestore.dart';


Future<String?> getUserRole(String phoneNumber) async {
  DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(phoneNumber).get();

  if (snapshot.exists) {
    return snapshot['role']; // Return the user's role
  }

  return null; // Return null if the user does not exist
}
Future<DateTime?> getUserSurgeryDate(String phoneNumber) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(phoneNumber).get();
      if (userDoc.exists && userDoc['surgeryDate'] != null) {
        Timestamp timestamp = userDoc['surgeryDate'];
        DateTime surgeryDate = timestamp.toDate();
        print("DK-"+surgeryDate.toString());
        return surgeryDate;
      }
    } catch (e) {
      print('Error retrieving surgery date: $e');
    }
    return null;
  }
