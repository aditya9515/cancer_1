import 'package:flutter/material.dart';

class OES18Form extends StatefulWidget {
  @override
  _OES18FormState createState() => _OES18FormState();
}

class _OES18FormState extends State<OES18Form> {
  List<int> _responses = List<int>.filled(18, 1); // 18 questions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EORTC OES18 Form',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        backgroundColor: Color.fromARGB(255, 255, 141, 34),
        elevation: 0,
      ),
      body: Container(
        color: Colors.teal.shade50, // Light background color for modern look
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 18,
                itemBuilder: (context, index) {
                  return _buildQuestion(_questions[index], index);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle form submission logic
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15), backgroundColor: Color.fromARGB(255, 255, 141, 34),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(String questionText, int index) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questionText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List<Widget>.generate(4, (i) {
                return Column(
                  children: [
                    Radio<int>(
                      value: i + 1,
                      groupValue: _responses[index],
                      activeColor: Color.fromARGB(255, 255, 141, 34),
                      onChanged: (value) {
                        setState(() {
                          _responses[index] = value!;
                        });
                      },
                    ),
                    Text('${i + 1}'),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  final List<String> _questions = [
    "1. Could you eat solid food?",
    "2. Could you eat liquidised or soft food?",
    "3. Could you drink liquids?",
    "4. Have you had trouble swallowing your saliva?",
    "5. Have you choked when swallowing?",
    "6. Have you had trouble enjoying your meals?",
    "7. Have you felt full too quickly?",
    "8. Have you had trouble with eating?",
    "9. Have you had trouble with eating in front of others?",
    "10. Have you had a dry mouth?",
    "11. Did food and drink taste different?",
    "12. Have you had trouble with coughing?",
    "13. Have you had trouble with talking?",
    "14. Have you had acid indigestion or heartburn?",
    "15. Have you had trouble with acid or bile?",
    "16. Have you had pain when you eat?",
    "17. Have you had pain in your chest?",
    "18. Have you had pain in your stomach?",
  ];
}
