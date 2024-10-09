import 'package:cancer/doctor/barcharts.dart';
import 'package:flutter/material.dart';
  // Correct import
import 'urgent_queries_screen.dart';
import 'wound_management_screen.dart';
import 'comments_screen.dart';
import 'next_visit_screen.dart';

class PatientDetailScreen extends StatelessWidget {
  final String patientPhoneNumber;  // Changed to patientPhoneNumber
  final String surgeryDate;

  const PatientDetailScreen({
    required this.patientPhoneNumber,  // Changed to patientPhoneNumber
    required this.surgeryDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient: $patientPhoneNumber'),  // Changed to display phone number
        backgroundColor: Colors.orange.shade600,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade100, Colors.orange.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Surgery Date: $surgeryDate',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade800,
                ),
              ),
              SizedBox(height: 20),
              _buildFeatureCard(
                context,
                title: 'Urgent Queries',
                icon: Icons.priority_high,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UrgentQueriesScreen(patientId: patientPhoneNumber),
                    ),
                  );
                },
              ),
              _buildFeatureCard(
                context,
                title: 'Wound Management',
                icon: Icons.healing,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WoundManagementScreen(patientId: patientPhoneNumber),
                    ),
                  );
                },
              ),
              _buildFeatureCard(
                context,
                title: 'Doctor/Nurse Comments',
                icon: Icons.comment,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CommentsScreen(patientId: patientPhoneNumber),
                    ),
                  );
                },
              ),
              _buildFeatureCard(
                context,
                title: 'Next Visit',
                icon: Icons.calendar_today,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NextVisitScreen(patientId: patientPhoneNumber),
                    ),
                  );
                },
              ),
              _buildFeatureCard(
                context,
                title: 'Bar Charts',  // Card for Bar Charts
                icon: Icons.bar_chart,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorBarCharts(
                        patientPhoneNumber: patientPhoneNumber,  // Updated to pass phone number
                        surgeryDate: surgeryDate // or pass actual patientId if needed
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build feature cards
  Widget _buildFeatureCard(BuildContext context,
      {required String title, required IconData icon, required Function onTap}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.orange.shade100,
          child: Icon(
            icon,
            color: Colors.orange.shade600,
            size: 28,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.orange.shade600,
        ),
        onTap: () => onTap(),
      ),
    );
  }
}