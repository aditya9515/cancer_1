import 'package:flutter/material.dart';

class LightExercisesScreen extends StatefulWidget {
  @override
  _LightExercisesScreenState createState() => _LightExercisesScreenState();
}

class _LightExercisesScreenState extends State<LightExercisesScreen> {
  final List<Map<String, dynamic>> exerciseData = [
    {'Day': 'Day 1', 'Steps': 0, 'Distance': 0.0, 'Stairs': 0, 'Running': 0.0}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Light Exercises',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: const Color.fromARGB(255, 241, 147, 39),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                      border: Border.all(
                        color: Color.fromARGB(255, 255, 166, 82),
                        width: 1.5,
                      ),
                    ),
                    child: Table(
                      columnWidths: {
                        0: FixedColumnWidth(100),
                        1: FixedColumnWidth(100),
                        2: FixedColumnWidth(100),
                        3: FixedColumnWidth(130),
                        4: FixedColumnWidth(160),
                      },
                      children: [
                        _buildTableHeader(),
                        for (int i = 0; i < exerciseData.length; i++)
                          _buildTableRow(i),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent, // Orange accent
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              ),
              onPressed: () {
                setState(() {
                  final newDay = {
                    'Day': 'Day ${exerciseData.length + 1}',
                    'Steps': 0,
                    'Distance': 0.0,
                    'Stairs': 0,
                    'Running': 0.0,
                  };
                  exerciseData.add(newDay);
                });
              },
              child: Text('Add Day', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // Table Header for the exercise table
  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 191, 131),
      ),
      children: [
        _buildCell('Day', isHeader: true),
        _buildCell('Steps', isHeader: true),
        _buildCell('Distance (km)', isHeader: true),
        _buildCell('Stairs Climbed', isHeader: true),
        _buildCell('Running Distance (km)', isHeader: true),
      ],
    );
  }

  // Each table row with input fields
  TableRow _buildTableRow(int dayIndex) {
    return TableRow(
      children: [
        _buildCell('Day ${dayIndex + 1}'),
        _buildInputField(dayIndex, 'Steps'),
        _buildInputField(dayIndex, 'Distance'),
        _buildInputField(dayIndex, 'Stairs'),
        _buildInputField(dayIndex, 'Running'),
      ],
    );
  }

  // Cell Builder (header or normal cell)
  Widget _buildCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: isHeader ? 16 : 14,
          color: isHeader ? const Color.fromARGB(255, 10, 6, 6) : Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  
  Widget _buildInputField(int dayIndex, String key) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: key,
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            if (key == 'Steps' || key == 'Stairs') {
              exerciseData[dayIndex][key] = int.tryParse(value) ?? 0;
            } else {
              exerciseData[dayIndex][key] = double.tryParse(value) ?? 0.0;
            }
          });
        },
      ),
    );
  }
}
