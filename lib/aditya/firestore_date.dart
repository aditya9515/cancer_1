import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch the surgery date from Firestore
  Future<DateTime?> getSurgeryDate(String userId) async {
    try {
      DocumentSnapshot userDoc = await _db.collection('users').doc(userId).get();
      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        if (userData['surgeryDate'] != null) {
          Timestamp timestamp = userData['surgeryDate'];
          return timestamp.toDate();  // Convert Firebase Timestamp to DateTime
        }
      }
    } catch (e) {
      print("Error retrieving surgery date: $e");
    }
    return null;
  }
}
