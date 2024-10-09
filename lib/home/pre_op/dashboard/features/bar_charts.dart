import 'package:cancer/aditya/pone_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class BarCharts extends StatefulWidget {
  String PhoneNumberDk = "";
  BarCharts(String phoneNumber){
    PhoneNumberDk = phoneNumber;
  }

 // String PhoneNumberdk = "";
  @override
  _BarChartsState createState() => _BarChartsState();
}

class _BarChartsState extends State<BarCharts> {
  List<Map<String, dynamic>> weeklyData = [];
  String selectedMetric = "Weight"; // Default metric for bar chart
  

  // Expected average values for each metric
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
    firestore.collection("Users").doc(widget.PhoneNumberDk).collection('health_data').get().then((querySnapshot) {
    if(querySnapshot.docs.isEmpty){
      weeklyData.add(_createWeekData());
    }
    else{
      for (var docSnapshot in querySnapshot.docs) {
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
  onError: (e) => print("Error completing: $e"),
);
  }

  // Helper method to create new week's entry
  Map<String, dynamic> _createWeekData() {
    return {
      'Weight': 0.0,
      'BMI': 0.0,
      'Albumin': 0.0,
      'Hemoglobin': 0.0,
      'HbA1c': 0.0,
      'BP': 0.0,
    };
  }

  void _addWeek() {
    setState(() {
      weeklyData.add(_createWeekData());
    });
  }

  void _removeWeek() {
    if (weeklyData.length > 1) {
      setState(() {
        weeklyData.removeLast();
      });
    }
  }
  Future<void> saveWeeklyHealthData(String phoneNumber, String weekId, int weight, int BMI, double albumin, double hemoglobin, double HbA1c, double BP) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentReference healthDataRef = firestore
      .collection('Users')
      .doc(phoneNumber) // Phone number as document ID
      .collection('health_data')
      .doc(weekId);  // Week-specific document

  await healthDataRef.set({
    'weight': weight,
    'BMI': BMI,
    'albumin': albumin,
    'hemoglobin': hemoglobin,
    'HbA1c': HbA1c,
    'BP': BP,
    'timestamp': FieldValue.serverTimestamp(),
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Metrics', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 252, 165, 34),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Data Entry Table
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    border: TableBorder.all(
                      color: const Color.fromARGB(255, 255, 161, 38),
                      width: 1.5,
                    ),
                    defaultColumnWidth: FixedColumnWidth(120.0),
                    children: [
                      _buildTableHeader(),
                      for (int i = 0; i < weeklyData.length; i++) _buildTableRow(i),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Assuming you want to save the last week's data
                final phoneNumber = Provider.of<PhoneProvider>(context, listen: false).phoneNumber; // Replace with actual phone number (or pass it dynamically)
                String weekId = 'week_${weeklyData.length}'; // e.g., week1, week2, week3...

                // Extract the last week's data (or you can loop through all weeks if you want to save more)
                Map<String, dynamic> lastWeekData = weeklyData.last;
              
                // Call the function to save the data to Firestore
                saveWeeklyHealthData(
                  phoneNumber,
                  weekId,
                  (lastWeekData['Weight'] ?? 0.0).toInt(), // Cast to int
                  (lastWeekData['BMI'] ?? 0.0).toInt(),    // Cast to int
                  lastWeekData['Albumin'] ?? 0.0,
                  lastWeekData['Hemoglobin'] ?? 0.0,
                  lastWeekData['HbA1c'] ?? 0.0,
                  lastWeekData['BP'] ?? 0.0
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 240, 144, 34),
                padding: EdgeInsets.all(12),
              ),
              child: Text("Save Week Data"),
              
            ),
            SizedBox(height: 20),
            // Add/Remove Week Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _addWeek,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 247, 126, 27),
                      padding: EdgeInsets.all(12),
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _removeWeek,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 241, 141, 48),
                      padding: EdgeInsets.all(12),
                    ),
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                ],
              ),
            ),
            // Metric Selection Buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SingleChildScrollView(
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
                                    ? const Color.fromARGB(255, 228, 113, 5)
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

  // Build the Table Header
  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 250, 208, 160),
      ),
      children: [
        _buildCell('Week', isHeader: true),
        _buildCell('Weight (Kg)', isHeader: true),
        _buildCell('BMI (Kg/m²)', isHeader: true),
        _buildCell('Albumin (g/dL)', isHeader: true),
        _buildCell('Hemoglobin (g/dL)', isHeader: true),
        _buildCell('HbA1c (%)', isHeader: true),
        _buildCell('Blood Pressure', isHeader: true),
      ],
    );
  }

  // Build each row in the table
  TableRow _buildTableRow(int weekIndex) {
    return TableRow(
      children: [
        _buildCell('Week ${weekIndex + 1}'),
        _buildInputField(weekIndex, 'Weight'),
        _buildInputField(weekIndex, 'BMI'),
        _buildInputField(weekIndex, 'Albumin'),
        _buildInputField(weekIndex, 'Hemoglobin'),
        _buildInputField(weekIndex, 'HbA1c'),
        _buildInputField(weekIndex, 'BP'),
      ],
    );
  }

  // Table Cell Builder
  Widget _buildCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 16 : 14,
          color: isHeader ? Colors.black87 : Colors.black54,
        ),
      ),
    );
  }

  // Input Field Builder
  Widget _buildInputField(int weekIndex, String key) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: key,
        ),
        keyboardType: TextInputType.number,
        initialValue: weeklyData[weekIndex][key].toString(),
        onChanged: (value) {
          setState(() {
            weeklyData[weekIndex][key] = double.tryParse(value) ?? 0;
          });
        },
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
              color: const Color.fromARGB(255, 241, 193, 119),
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
