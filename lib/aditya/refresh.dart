import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataProvider with ChangeNotifier {
  // Store user data
  Map<String, dynamic> healthData = {};
  List<Map<String, dynamic>> damagedBodyParts = [];
  Map<String, dynamic> activityLogs = {};
  List<Map<String, dynamic>> nutritionRehabilitation = [];
  Map<String, bool> preSurgeryChecklist = {};
  

  // Fetch health data (subcollection: health_data)
  Future<void> fetchHealthData(String userId) async {
    var healthDataCollection = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('health_data')
        .get();

    for (var doc in healthDataCollection.docs) {
      healthData[doc.id] = doc.data();
    }
    notifyListeners();
  }

  // Fetch damaged body parts (subcollection: damaged_body_parts)
  Future<void> fetchDamagedBodyParts(String userId) async {
    var bodyPartsCollection = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('damaged_body_parts')
        .get();

    damagedBodyParts = bodyPartsCollection.docs.map((doc) => doc.data()).toList();
    notifyListeners();
  }

  // Fetch nutrition rehabilitation data (subcollection: nutrition_rehabilitation)
  Future<void> fetchNutritionRehabilitation(String userId) async {
    var nutritionCollection = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('nutrition_rehabilitation')
        .get();

    nutritionRehabilitation = nutritionCollection.docs.map((doc) => doc.data()).toList();
    notifyListeners();
  }

  // Fetch pre-surgery checklist data (subcollection: pre_surgery_checklist)
  Future<void> fetchPreSurgeryChecklist(String userId) async {
    var checklistDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('pre_surgery_checklist')
        .doc('checklist')
        .get();

    if (checklistDoc.exists) {
      preSurgeryChecklist = checklistDoc.data()!.cast<String, bool>();
    }
    notifyListeners();
  }

  // Fetch activity logs (document: alcohol_smoke)
  Future<void> fetchActivityLogs(String userId) async {
    var activityLogsDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('alcohol_smoke')
        .doc('logs')
        .get();

    if (activityLogsDoc.exists) {
      activityLogs = activityLogsDoc.data()!;
    }
    notifyListeners();
  }

  // Refresh all user data
  Future<void> refreshUserData(String userId) async {
    await Future.wait([
      fetchHealthData(userId),
      fetchDamagedBodyParts(userId),
      fetchNutritionRehabilitation(userId),
      fetchPreSurgeryChecklist(userId),
      fetchActivityLogs(userId),
    ]);
  }
}
