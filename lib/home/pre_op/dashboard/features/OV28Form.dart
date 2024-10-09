import 'package:flutter/material.dart';

class OV28Form extends StatefulWidget {
  @override
  _OV28FormState createState() => _OV28FormState();
}

class _OV28FormState extends State<OV28Form> {
  List<int> _responses = List<int>.filled(28, 1); // 28 questions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EORTC OV28 Form',
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
    "1. Did you have abdominal pain?",
    "2. Did you have a bloated feeling in your abdomen?",
    "3. Did you have problems with your clothes feeling too tight?",
    "4. Have you had difficulty breathing?",
    "5. Have you felt pain in your lower back?",
    "6. Have you had pain or discomfort in your lower abdomen?",
    "7. Did you feel your belly had grown?",
    "8. Did you experience increased tiredness?",
    "9. Did you have trouble with sleeping?",
    "10. Did you experience hot flushes?",
    "11. Did you feel a loss of appetite?",
    "12. Did you have trouble with constipation?",
    "13. Did you have diarrhea?",
    "14. Did you have trouble passing urine?",
    "15. Did you experience changes in your bowel habits?",
    "16. Did you feel emotionally tense or stressed?",
    "17. Did you experience depression?",
    "18. Did you experience pain when sitting down?",
    "19. Did you experience pain while moving?",
    "20. Did you have swelling in your legs?",
    "21. Did you feel pain in your pelvic area?",
    "22. Did you experience nausea or vomiting?",
    "23. Did you have difficulties with your sexual life?",
    "24. Did you feel fatigued most of the time?",
    "25. Did you experience weight gain?",
    "26. Did you experience weight loss?",
    "27. Did you feel a loss of interest in everyday activities?",
    "28. Did you have trouble concentrating on tasks?",
  ];
}
