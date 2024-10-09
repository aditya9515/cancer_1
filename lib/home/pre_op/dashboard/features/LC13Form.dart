import 'package:flutter/material.dart';

class LC13Form extends StatefulWidget {
  @override
  _LC13FormState createState() => _LC13FormState();
}

class _LC13FormState extends State<LC13Form> {
  List<int> _responses = List<int>.filled(13, 1); // 13 questions, default response = 1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EORTC LC13 Form',
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
                itemCount: 13,
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
    "1. How much did you cough?",
    "2. Did you cough up blood?",
    "3. Were you short of breath when you rested?",
    "4. Were you short of breath when you walked?",
    "5. Were you short of breath when you climbed stairs?",
    "6. Have you had a sore mouth or tongue?",
    "7. Have you had trouble swallowing?",
    "8. Have you had tingling hands or feet?",
    "9. Have you had hair loss?",
    "10. Have you had pain in your chest?",
    "11. Have you had pain in your arm or shoulder?",
    "12. Have you had pain in other parts of your body?",
    "13. Did you take any medicine for pain?",
  ];
}
