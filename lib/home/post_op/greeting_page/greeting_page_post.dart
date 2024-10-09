import 'package:flutter/material.dart';

class GreetingPagePost extends StatefulWidget {
  const GreetingPagePost({Key? key}) : super(key: key);

  @override
  _GreetingPagePostState createState() => _GreetingPagePostState();
}

class _GreetingPagePostState extends State<GreetingPagePost> {
  final List<String> surgeries = [
    'Esophagus Surgery',
    'Stomach Surgery',
    'Colon Surgery',
    'Rectum Surgery',
    'Ovary Surgery',
    'Endometrium Surgery',
    'Lung Surgery',
  ];

  final Map<String, String> surgeryDescriptions = {
    'Esophagus Surgery': 'Esophagus surgery involves treatment for cancer...',
    'Stomach Surgery': 'Stomach surgery treats conditions like cancer...',
    'Colon Surgery': 'Colon surgery, or colectomy, is for colon cancer...',
    'Rectum Surgery': 'Rectum surgery treats cancer, prolapse, and other...',
    'Ovary Surgery': 'Ovary surgery removes ovarian cysts or treats cancer...',
    'Endometrium Surgery': 'Endometrium surgery treats endometrial cancer...',
    'Lung Surgery': 'Lung surgery treats lung cancer, infections, or COPD...',
  };

  String? selectedSurgery;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Surgery:',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 5, 4)),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.orange, width: 1),
                ),
              ),
              isExpanded: true,
              value: selectedSurgery,
              hint: const Text('Choose Surgery'),
              items: surgeries.map((String surgery) {
                return DropdownMenuItem<String>(
                  value: surgery,
                  child: Text(surgery),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedSurgery = newValue;
                });
              },
              style: TextStyle(
                color: const Color.fromARGB(221, 0, 0, 0),
                fontSize: 16,
              ),
              dropdownColor: const Color.fromARGB(255, 255, 213, 145),
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 20),
            if (selectedSurgery != null) ...[
              Text(
                selectedSurgery!,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              const SizedBox(height: 10),
              Text(
                surgeryDescriptions[selectedSurgery!]!,
                style: const TextStyle(fontSize: 16),
              ),
            ],
            const SizedBox(height: 80),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/congratulations.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Congratulations!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Wish you a speedy recovery!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
