import 'package:cancer/aditya/pone_provider.dart';
import 'package:flutter/material.dart';
import 'package:cancer/home/post_op/dashboard/features/form_selection.dart';
import 'package:cancer/home/pre_op/dashboard/features/bar_charts.dart';
import 'package:cancer/home/pre_op/dashboard/features/nutrition_rehab.dart';
import 'package:cancer/home/pre_op/dashboard/features/diet_chart.dart';
import 'package:cancer/home/pre_op/dashboard/features/checklist.dart';
import 'package:cancer/home/pre_op/dashboard/features/medicines.dart';
import 'package:cancer/home/pre_op/dashboard/features/alcoholsmoking.dart';
import 'package:cancer/home/pre_op/dashboard/features/exercises.dart';
import 'package:provider/provider.dart';
class Dashboard extends StatelessWidget {
   Dashboard({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> features = [
    {'title': 'Bar Charts', 'icon': Icons.bar_chart},
    {'title': 'Nutrition Rehab', 'icon': Icons.restaurant},
    {'title': 'Diet Chart', 'icon': Icons.food_bank},
    {'title': 'Checklist', 'icon': Icons.checklist},
    {'title': 'Medicines', 'icon': Icons.medication},
    {'title': 'Feedback', 'icon': Icons.feedback},
    {'title': 'Alcohol & Smoking', 'icon': Icons.smoking_rooms},
    {'title': 'Exercises', 'icon': Icons.directions_run},
    {'title': 'EORTC', 'icon': Icons.pages},
    
  ];

  void navigateToFeature(BuildContext context, int featureIndex) {
    Widget nextScreen;

    switch (featureIndex) {
      case 1:
        nextScreen = BarCharts(Provider.of<PhoneProvider>(context, listen: false).phoneNumber);
        break;
      case 2:
        nextScreen = NutritionRehabPage(Provider.of<PhoneProvider>(context, listen: false).phoneNumber);
        break;
      case 3:
        nextScreen = SimpleDiet();
        break;
      case 4:
        nextScreen = ChecklistPage(Provider.of<PhoneProvider>(context, listen: false).phoneNumber);
        break;
      case 5:
        nextScreen = PrescriptionScreen();
        break;
      case 6:
        nextScreen = FormSelectionScreen();
        break;
      case 7:
        nextScreen = AlcoholSmokingFeature('+919876543210');
        break;
      case 8:
        nextScreen = EntryScreen();
        break;
      case 9:
        nextScreen = AlcoholSmokingFeature('+919876543210');
        break;

      default:
        nextScreen = Scaffold(
            body: Center(child: Text('Feature Not Implemented Yet')));
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0, // Ensures that each tile is square
              children: List.generate(9, (index) {
                return _buildFeatureCard(context, index + 1);
              }),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, int featureIndex) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
        ),
      elevation: 2,
      child: InkWell(
        onTap: () => navigateToFeature(context, featureIndex),
        borderRadius: BorderRadius.circular(12),
        splashColor: const Color.fromARGB(255, 245, 132, 26).withOpacity(0.4),
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Adjusted padding for more space
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Ensures it takes only the necessary space
            children: [
              Flexible(
                child: Icon(
                  features[featureIndex - 1]['icon'], // Dynamic icon
                  size: 30, // Reduced icon size to fit
                  color: Color(0xFFFF6F00),
                ),
              ),
              const SizedBox(height: 5), // Reduced spacing
              Flexible(
                child: Text(
                  features[featureIndex - 1]['title'], // Dynamic title
                  style: TextStyle(
                    fontSize: 14, // Reduced font size to fit
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center, // Ensure text is centered
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
