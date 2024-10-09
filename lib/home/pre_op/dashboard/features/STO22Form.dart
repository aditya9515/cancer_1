import 'package:flutter/material.dart';

class STO22Form extends StatefulWidget {
  @override
  _STO22FormState createState() => _STO22FormState();
}

class _STO22FormState extends State<STO22Form> {
  List<int> _responses = List<int>.filled(22, 1); // 22 questions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EORTC STO22 Form',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 141, 34),
        elevation: 0,
      ),
      body: Container(
        color: Colors.deepOrange.shade50, // Light background color for modern look
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
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
    "1. Have you had problems eating solid foods?",
    "2. Have you had problems eating liquidised foods?",
    "3. Have you had problems drinking liquids?",
    "4. Have you felt nauseous?",
    "5. Have you experienced any heartburn?",
    "6. Have you had any problems with your teeth?",
    "7. Have you experienced a dry mouth?",
    "8. Have you had difficulties swallowing?",
    "9. Have you had a sore throat?",
    "10. Have you experienced weight loss?",
    "11. Have you felt full after eating small amounts?",
    "12. Have you experienced pain when eating?",
    "13. Have you had a change in taste?",
    "14. Have you felt a lack of appetite?",
    "15. Have you experienced any reflux?",
    "16. Have you had indigestion?",
    "17. Have you experienced bloating?",
    "18. Have you had trouble finishing your meals?",
    "19. Have you felt pain in your stomach?",
    "20. Have you had any food allergies?",
    "21. Have you experienced fatigue after meals?",
    "22. Have you experienced any discomfort in your abdomen?",
  ];
}
