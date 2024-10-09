import 'package:flutter/material.dart';



class ActivityRatingFeature extends StatefulWidget {
  @override
  _ActivityRatingFeatureState createState() => _ActivityRatingFeatureState();
}

class _ActivityRatingFeatureState extends State<ActivityRatingFeature> {
  int? selectedDay; // Tracks the selected day (1, 2, 3, or 4)

  // Handles the visual state change on selection
  void _selectDay(int day) {
    setState(() {
      selectedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Text
          Text(
            "How many days did you engage in physical activity this week?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),

          // Rating Options (1 to 4 Days)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (index) {
              int day = index + 1;
              return GestureDetector(
                onTap: () => _selectDay(day),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: selectedDay == day
                        ? Colors.blueAccent
                        : Colors.grey[300], // Change color when selected
                  ),
                  child: Text(
                    "$day Day${day > 1 ? 's' : ''}",
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedDay == day ? Colors.white : Colors.black,
                      fontWeight: selectedDay == day
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 30),

          // Submit Button
          Center(
            child: ElevatedButton(
              onPressed: selectedDay == null
                  ? null // Disable button if no day is selected
                  : () {
                      _showSubmitDialog();
                    },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
              child: Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }

  // Dialog to show submission confirmation
  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Submission Successful"),
          content: Text("You rated $selectedDay day${selectedDay! > 1 ? 's' : ''}."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
