import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class GreetingPage extends StatefulWidget {
  const GreetingPage({Key? key}) : super(key: key);

  @override
  _GreetingPageState createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {
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
    'Esophagus Surgery':
        'Esophagus surgery involves treatment for cancer, removal of tumors, and management of esophageal disorders.',
    'Stomach Surgery':
        'Stomach surgery treats conditions like cancer, ulcers, and obesity, including gastric bypass for weight loss.',
    'Colon Surgery':
        'Colon surgery, or colectomy, is for colon cancer, IBD, or severe diverticulitis, sometimes involving a colostomy.',
    'Rectum Surgery':
        'Rectum surgery treats cancer, prolapse, and other rectal issues, including tumor removal or tissue reconstruction.',
    'Ovary Surgery':
        'Ovary surgery removes ovarian cysts or treats cancer, sometimes involving laparoscopic techniques.',
    'Endometrium Surgery':
        'Endometrium surgery treats endometrial cancer or abnormal bleeding, including hysterectomies or ablations.',
    'Lung Surgery':
        'Lung surgery treats lung cancer, infections, or COPD through procedures like lobectomy or pneumonectomy.',
  };

  final Map<String, List<DateTime>> surgeryDates = {
    'Esophagus Surgery': [DateTime.utc(2024, 10, 15), DateTime.utc(2024, 11, 5)],
    'Stomach Surgery': [DateTime.utc(2024, 10, 20), DateTime.utc(2024, 11, 18)],
    'Colon Surgery': [DateTime.utc(2024, 10, 25)],
    'Rectum Surgery': [DateTime.utc(2024, 11, 1)],
    'Ovary Surgery': [DateTime.utc(2024, 11, 10), DateTime.utc(2024, 12, 1)],
    'Endometrium Surgery': [DateTime.utc(2024, 11, 15)],
    'Lung Surgery': [DateTime.utc(2024, 12, 5)],
  };

  String? selectedSurgery;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  int? daysUntilNextSurgery;

  int? calculateDaysUntilNextSurgery() {
    if (selectedSurgery != null && surgeryDates[selectedSurgery!] != null) {
      List<DateTime> dates = surgeryDates[selectedSurgery!]!;
      DateTime today = DateTime.now();
      DateTime? closestDate;

      for (DateTime date in dates) {
        if (date.isAfter(today)) {
          closestDate = date;
          break;
        }
      }

      if (closestDate != null) {
        return closestDate.difference(today).inDays;
      }
    }
    return null;
  }

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
                color: Color.fromARGB(255, 5, 5, 4),
              ),
            ),
            SizedBox(height: 10),
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
                  selectedDay = null;
                  daysUntilNextSurgery = calculateDaysUntilNextSurgery();
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
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                surgeryDescriptions[selectedSurgery!]!,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              if (daysUntilNextSurgery != null)
                Text(
                  'Surgery is in $daysUntilNextSurgery days!',
                  style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.red,
                  ),
                ),
              const SizedBox(height: 20),
              const Text(
                'Surgery Calendar:',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 10),
              TableCalendar(
                firstDay: DateTime.utc(2022, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    this.selectedDay = selectedDay;
                    this.focusedDay = focusedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: const BoxDecoration(
                    color: Colors.orangeAccent,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  markerDecoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  markerSize: 8,
                  outsideDaysVisible: false,
                ),
                eventLoader: (day) {
                  if (selectedSurgery != null &&
                      surgeryDates[selectedSurgery!] != null) {
                    return surgeryDates[selectedSurgery!]!.contains(day)
                        ? [surgeryDescriptions[selectedSurgery!]]
                        : [];
                  }
                  return [];
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
