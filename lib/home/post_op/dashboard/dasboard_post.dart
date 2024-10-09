import 'package:flutter/material.dart';
import 'package:cancer/home/post_op/dashboard/features/exercises.dart';
import 'package:cancer/home/post_op/dashboard/features/drainchart.dart';
import 'package:cancer/home/post_op/dashboard/features/form_selection.dart';
import 'package:cancer/home/post_op/dashboard/features/hospital_visit.dart';
import 'package:cancer/home/post_op/dashboard/features/pain_management.dart';
import 'package:cancer/home/post_op/dashboard/features/queryscreen.dart';
import 'package:cancer/home/post_op/dashboard/features/diet_chart.dart';
import 'package:cancer/home/post_op/dashboard/features/medicines.dart';
import 'package:cancer/home/post_op/dashboard/features/wound_management.dart';

class PostOpDashboard extends StatelessWidget {
  const PostOpDashboard({Key? key}) : super(key: key);

  // Navigation function to feature screens
  void navigateToFeature(BuildContext context, int featureIndex) {
    Widget nextScreen;

    switch (featureIndex) {
      case 1:
        nextScreen = PainManagement();
        break;
      case 2:
        nextScreen = PrescriptionScreen();
        break;
      case 3:
        nextScreen = WoundManagement();
        break;
      case 4:
        nextScreen = SimpleDiet();
        break;
      case 5:
        nextScreen = EntryScreen();
        break;
      case 6:
        nextScreen = DrainVolumeTable();
        break;
      case 7:
        nextScreen = QueryScreen();
        break;
      case 8:
        nextScreen = HospitalVisitCalendar();
        break;
      case 9:
        nextScreen = FormSelectionScreen();
        break;
      default:
        nextScreen = const Scaffold(
          body: Center(child: Text('Feature Not Implemented Yet')),
        );
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  // GridView for feature cards
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Wrap the GridView in SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 3, // Keeping the 3x3 layout
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true, // Use shrinkWrap to fit the content size
            physics: NeverScrollableScrollPhysics(), // Disable scrolling of GridView
            children: List.generate(9, (index) {
              return _buildFeatureCard(context, index + 1);
            }),
          ),
        ),
      ),
    );
  }

  // Function to create feature cards with actual feature names and icons
  Widget _buildFeatureCard(BuildContext context, int featureIndex) {
    final Map<int, String> featureNames = {
      1: "Query",
      2: "Medicines",
      3: "Query",
      4: "Diet Chart",
      5: "Exercises",
      6: "Drain Volume",
      7: "Queries",
      8: "Hospital Visit",
      9: "EORTC",
    };

    final Map<int, IconData> featureIcons = {
      1: Icons.question_answer,    // Icon for Query Doctor
      2: Icons.local_pharmacy,     // Icon for Prescriptions
      3: Icons.question_answer,     // Icon for Daily Exercise
      4: Icons.restaurant,         // Icon for Diet Chart
      5: Icons.fitness_center,         // Icon for Record Medicines
      6: Icons.science,            // Icon for Drain Volume
      7: Icons.question_answer,       // Icon for Patient Queries
      8: Icons.calendar_today,     // Icon for Hospital Visit
      9: Icons.assignment,         // Icon for Form Selection
    };

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 4,
      child: InkWell(
        onTap: () => navigateToFeature(context, featureIndex),
        borderRadius: BorderRadius.circular(12),
        splashColor: const Color.fromARGB(255, 252, 156, 46).withOpacity(0.4),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                featureIcons[featureIndex], // Specific icon for each feature
                size: 30, // Decrease icon size here
                color: const Color.fromARGB(255, 211, 114, 3),
              ),
              SizedBox(height: 5), // Decrease space between icon and text
              Text(
                featureNames[featureIndex]!, // Specific name for each feature
                textAlign: TextAlign.center, // Center align the text
                style: TextStyle(
                  fontSize: 14, // Keep font size here
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
