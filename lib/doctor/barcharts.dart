import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DoctorBarCharts extends StatefulWidget {
  final String patientPhoneNumber;

  DoctorBarCharts({required this.patientPhoneNumber, required String surgeryDate});

  @override
  _DoctorBarChartsState createState() => _DoctorBarChartsState();
}

class _DoctorBarChartsState extends State<DoctorBarCharts> {
  List<Map<String, dynamic>> weeklyData = [];
  String selectedMetric = "Weight"; // Default metric for bar chart

  final Map<String, double> expectedValues = {
    'Weight': 70.0,
    'BMI': 22.0,
    'Albumin': 4.0,
    'Hemoglobin': 14.0,
    'HbA1c': 5.5,
    'BP': 120.0,
  };

  @override
  void initState() {
    super.initState();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    print("AD- created instence");
    firestore.collection("Users").doc(widget.patientPhoneNumber).collection('health_data').get().then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        for (var docSnapshot in querySnapshot.docs) {
          print("AD- insode loop"+docSnapshot['weight'].toString());
          Map<String, dynamic> filteredData = {
            'Weight': docSnapshot['weight'],
            'BMI': docSnapshot['BMI'],
            'Albumin': docSnapshot['albumin'],
            'Hemoglobin': docSnapshot['hemoglobin'],
            'HbA1c': docSnapshot['HbA1c'],
            'BP': docSnapshot['BP'],
          };
          setState(() {
            weeklyData.add(filteredData);
          });
        }
      }
    },
    onError: (e) => print("Error loading data: $e"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Health Metrics', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 238, 158, 39),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            // Metric Selection Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ['Weight', 'BMI', 'Albumin', 'Hemoglobin', 'HbA1c', 'BP']
                    .map((metric) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedMetric = metric;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: selectedMetric == metric
                                  ? const Color.fromARGB(255, 245, 176, 49)
                                  : Colors.grey.shade200,
                              foregroundColor: selectedMetric == metric
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            child: Text(metric),
                          ),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(height: 20),
            // Bar Chart
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final screenWidth = constraints.maxWidth;
                    final chartWidth = (weeklyData.length * 120.0)
                        .clamp(screenWidth, double.infinity);

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: chartWidth,
                        child: BarChart(
                          _buildBarChart(selectedMetric),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bar Chart Builder
  BarChartData _buildBarChart(String metric) {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < weeklyData.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: expectedValues[metric] ?? 0,
              color: const Color.fromARGB(255, 250, 207, 126),
              width: 20,
            ),
            BarChartRodData(
              toY: (weeklyData[i][metric] ?? 0).toDouble(),
              color: Colors.orange,
              width: 20,
            ),
          ],
        ),
      );
    }

    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            getTitlesWidget: (value, meta) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Week ${value.toInt() + 1}'),
            ),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 60,
            getTitlesWidget: (value, meta) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value.toString()),
            ),
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: barGroups,
    );
  }
}