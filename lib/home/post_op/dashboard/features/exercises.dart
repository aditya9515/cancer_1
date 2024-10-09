import 'package:flutter/material.dart';
import 'package:cancer/home/post_op/dashboard/features/incentivespiromentry.dart';
import 'package:cancer/home/post_op/dashboard/features/lightexercises.dart';

class EntryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Health Activities',
          style: TextStyle(color: const Color.fromARGB(221, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 248, 146, 29),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color.fromARGB(221, 255, 255, 255)),
          onPressed: () {
            Navigator.of(context).pop(); // Go back to previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  // Incentive Spirometry Card
                  _buildActivityCard(
                    'Incentive Spirometry',
                    'Track your incentive spirometry progress.',
                    Icons.air,
                    Color.fromARGB(255, 245, 132, 26),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IncentiveSpirometryScreen(),
                        ),
                      );
                    },
                  ),
                  // Light Exercises Card
                  _buildActivityCard(
                    'Light Exercises',
                    'Log your light exercise activities.',
                    Icons.fitness_center,
                    Color.fromARGB(255, 245, 132, 26),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LightExercisesScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Modern Activity Card UI
  Widget _buildActivityCard(String title, String subtitle, IconData icon, Color iconBgColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 158, 158, 158).withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3), // Shadow positioning
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            // Icon with background circle
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: iconBgColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: iconBgColor),
            ),
            SizedBox(width: 16.0),
            // Title and subtitle
            Expanded(
              child: Column(
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
                    subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
