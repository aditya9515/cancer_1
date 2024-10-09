import 'package:flutter/material.dart';

class SimpleDiet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Diet Chart'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 255, 255, 255),), // Custom back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Diet Chart',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Breakfast: Oats, Fruits, and Milk'),
            Text('Lunch: Brown Rice, Chicken, and Vegetables'),
            Text('Dinner: Salad and Soup'),
          ],
        ),
      ),
    );
  }
}
