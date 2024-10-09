import 'package:flutter/material.dart';

class WongBakerRating extends StatelessWidget {
  final Function(double) onSelected;

  WongBakerRating({required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Heading
            
            SizedBox(height: 16),
            // Remaining Pain Scores
            Column(
              children: List.generate(11, (index) {
                return GestureDetector(
                  onTap: () => onSelected(index.toDouble()),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 252, 196, 112),
                          const Color.fromARGB(255, 252, 196, 112),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14.0,
                      horizontal: 16.0,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _getPainDescription(index),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          index.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  String _getPainDescription(int index) {
    switch (index) {
      case 0:
        return 'No pain';
      case 1:
        return 'Mild pain';
      case 2:
        return 'Moderate pain';
      case 3:
        return 'Moderate pain';
      case 4:
        return 'Moderate to severe pain';
      case 5:
        return 'Severe pain';
      case 6:
        return 'Very severe pain';
      case 7:
        return 'Intense pain';
      case 8:
        return 'Worst possible pain';
      case 9:
        return 'Excruciating pain';
      case 10:
        return 'Unbearable pain';
      default:
        return 'Unknown';
    }
  }
}
