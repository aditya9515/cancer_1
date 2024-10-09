import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class NutritionRehabPage extends StatefulWidget {
  NutritionRehabPage(String phoneNumber);

  @override
  _NutritionRehabPageState createState() => _NutritionRehabPageState();
}

class _NutritionRehabPageState extends State<NutritionRehabPage> {
  List<double> proteinIntake = [50, 75, 80, 65, 90, 85, 100];

  void _addProteinIntake(double intake) {
    setState(() {
      proteinIntake.add(intake);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition Rehabilitation'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20 ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 255, 255, 255),), // Custom back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 250, 143, 3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First half: Sample Diet Chart
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                    Text(
                      'Sample Diet Chart',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 250, 143, 3),
                      ),
                    ),
                    SizedBox(height: 10),
                    Table(
                      border: TableBorder.all(
                        color:Color.fromARGB(255, 250, 143, 3),
                        width: 2.0,
                      ),
                      children: [
                        _buildTableRow('Meal', 'Food Items', isHeader: true),
                        _buildTableRow('Breakfast', 'Oats, Milk, Fruits'),
                        _buildTableRow('Lunch', 'Grilled Chicken, Veggies, Rice'),
                        _buildTableRow('Dinner', 'Salmon, Quinoa, Salad'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Second half: Protein Intake Line Chart
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Protein Intake (grams) vs Day',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 250, 143, 3),
                    ),
                  ),
                  Expanded(
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: List.generate(
                              proteinIntake.length,
                              (index) => FlSpot(index.toDouble(), proteinIntake[index]),
                            ),
                            isCurved: true,
                            color: Color.fromARGB(255, 250, 143, 3),
                            barWidth: 4,
                            belowBarData: BarAreaData(show: false),
                            dotData: FlDotData(show: true),
                          ),
                        ],
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  'Day ${value.toInt() + 1}',
                                  style: TextStyle(fontSize: 12),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: TextStyle(fontSize: 12),
                                );
                              },
                            ),
                          ),
                        ),
                        gridData: FlGridData(show: true),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: Color.fromARGB(255, 250, 143, 3)),
                        ),
                        minX: 0,
                        maxX: proteinIntake.length > 7
                            ? proteinIntake.length.toDouble() - 1
                            : 6,
                        minY: 0,
                        maxY: proteinIntake.reduce((a, b) => a > b ? a : b) + 10,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter Protein Intake (grams)',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onSubmitted: (value) {
                              double intake = double.tryParse(value) ?? 0;
                              if (intake > 0) {
                                _addProteinIntake(intake);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String meal, String items, {bool isHeader = false}) {
    return TableRow(
      decoration: BoxDecoration(
        color: isHeader ? Color.fromARGB(255, 255, 214, 161) : Colors.white,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            meal,
            style: TextStyle(
              fontSize: isHeader ? 16 : 14,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            items,
            style: TextStyle(
              fontSize: isHeader ? 16 : 14,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
