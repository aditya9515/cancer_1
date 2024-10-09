import 'package:flutter/material.dart';
import 'wong_baker_rating.dart'; // Import the Wong-Baker rating widget

class PainManagement extends StatefulWidget {
  @override
  _PainManagementState createState() => _PainManagementState();
}

class _PainManagementState extends State<PainManagement> {
  List<PainScore> painScores = [
    PainScore(day: 'Day 1'),
    PainScore(day: 'Day 2'),
    PainScore(day: 'Day 3'),
  ];

  void _showWongBakerRating(BuildContext context, int index, String timeOfDay) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pain Score for ${painScores[index].day} - $timeOfDay'),
          content: WongBakerRating(
            onSelected: (value) {
              setState(() {
                _setScore(index, timeOfDay, value);
              });
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _addDay() {
    setState(() {
      int dayCount = painScores.length + 1;
      painScores.add(PainScore(day: 'Day $dayCount'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pain Management'),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 4.0, // Adding a subtle shadow to the AppBar
        flexibleSpace:  Container(
          decoration:const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 255, 141, 34), Color.fromARGB(255, 255, 141, 34)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Time labels row displayed below AppBar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 45,),
                Text(
                  'Morning',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
                
                Text(
                  'Afternoon',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
                Text(
                  'Evening',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: painScores.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            painScores[index].day,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                          _buildScoreColumn(context, index, 'Morning'),
                          _buildScoreColumn(context, index, 'Afternoon'),
                          _buildScoreColumn(context, index, 'Evening'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: _addDay,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              child: Text(
                'Add Day',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildScoreColumn(BuildContext context, int index, String timeOfDay) {
    double score;
    switch (timeOfDay) {
      case 'Morning':
        score = painScores[index].morningScore;
        break;
      case 'Afternoon':
        score = painScores[index].afternoonScore;
        break;
      case 'Evening':
        score = painScores[index].eveningScore;
        break;
      default:
        score = 0.0;
    }

    return Column(
      children: [
        TextButton(
          onPressed: () => _showWongBakerRating(context, index, timeOfDay),
          style: TextButton.styleFrom(
            backgroundColor: Colors.orange.shade100,
            foregroundColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
          ),
          child: Text(
            score > 0 ? score.toStringAsFixed(1) : 'Input',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _setScore(int index, String timeOfDay, double value) {
    switch (timeOfDay) {
      case 'Morning':
        painScores[index].morningScore = value;
        break;
      case 'Afternoon':
        painScores[index].afternoonScore = value;
        break;
      case 'Evening':
        painScores[index].eveningScore = value;
        break;
    }
  }
}

class PainScore {
  final String day;
  double morningScore;
  double afternoonScore;
  double eveningScore;

  PainScore({
    required this.day,
    this.morningScore = 0.0,
    this.afternoonScore = 0.0,
    this.eveningScore = 0.0,
  });
}
