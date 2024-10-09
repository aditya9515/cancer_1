import 'package:flutter/material.dart';

class DrainVolumeTable extends StatefulWidget {
  const DrainVolumeTable({Key? key}) : super(key: key);

  @override
  _DrainVolumeTableState createState() => _DrainVolumeTableState();
}

class _DrainVolumeTableState extends State<DrainVolumeTable> {
  List<Map<String, dynamic>> drainVolumeData = [
    {
      'date': null,
      'volume': ''
    }, // No default date, placeholder for 'Select Date'
  ];

  void _addNewRow() {
    setState(() {
      drainVolumeData.add({'date': null, 'volume': ''});
    });
  }

  Future<void> _selectDate(int index) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        drainVolumeData[index]['date'] = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drain Volume Tracker'),
        backgroundColor: Colors.orange,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(150),
                    1: FlexColumnWidth(),
                  },
                  border: TableBorder.all(
                    color: Colors.orange,
                    width: 2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  children: [
                    // Table Header
                    TableRow(
                      decoration: BoxDecoration(color: Colors.orange.shade100),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Date',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Drain Volume (ml)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    // Table Rows
                    for (int i = 0; i < drainVolumeData.length; i++)
                      TableRow(
                        children: [
                          GestureDetector(
                            onTap: () => _selectDate(i),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                drainVolumeData[i]['date'] == null
                                    ? 'Select Date'
                                    : "${drainVolumeData[i]['date'].day}/${drainVolumeData[i]['date'].month}/${drainVolumeData[i]['date'].year}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: drainVolumeData[i]['date'] == null
                                      ? Colors.grey
                                      : Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  drainVolumeData[i]['volume'] = value;
                                });
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Enter volume',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            // Add Day Button
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton.icon(
                onPressed: _addNewRow,
                icon: Icon(Icons.add,
                    color: Colors.orange), // Icon color set to orange
                label: Text(
                  'Add Day',
                  style: TextStyle(
                      color: Colors.orange), // Text color set to orange
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  backgroundColor:
                      Colors.white, // Background color set to white
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                        color: Colors
                            .orange), // Add orange border to match the theme
                  ),
                  elevation: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
