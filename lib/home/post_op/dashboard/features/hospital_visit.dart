import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // For formatting date display

class HospitalVisitCalendar extends StatefulWidget {
  @override
  _HospitalVisitCalendarState createState() => _HospitalVisitCalendarState();
}

class _HospitalVisitCalendarState extends State<HospitalVisitCalendar> {
  // Mock data: Replace this with data from Firebase later
  final Map<DateTime, List<String>> _hospitalVisits = {
    DateTime.utc(2024, 10, 10): ['Surgery consultation'],
    DateTime.utc(2024, 10, 14): ['Post-op Checkup'],
    DateTime.utc(2024, 10, 18): ['Physiotherapy'],
  };

  // To track which day is selected
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List<String> _getEventsForDay(DateTime day) {
    return _hospitalVisits[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:  const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 247, 182, 43), Color.fromARGB(255, 253, 212, 100)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'Upcoming Hospital Visits',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Calendar widget
          TableCalendar(
            firstDay: DateTime.utc(2023, 10, 1),
            lastDay: DateTime.utc(2025, 10, 1),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getEventsForDay,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: const Color.fromARGB(255, 248, 212, 92).withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 180, 68),
                shape: BoxShape.circle,
              ),
              markersMaxCount: 1,
              markerDecoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 187, 60),
                shape: BoxShape.circle,
              ),
              weekendTextStyle: TextStyle(color: const Color.fromARGB(255, 255, 180, 82)),
              outsideDaysVisible: false,
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
            ),
          ),
          SizedBox(height: 20),

          // Display upcoming hospital visits for the selected day
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
    );
  }

  // Build the event list for selected date
  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDay);

    if (events.isEmpty) {
      return Center(
        child: Text(
          'No visits on this day',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: Icon(Icons.medical_services, color: Colors.blueAccent),
            title: Text(
              events[index],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              DateFormat('EEEE, MMM d').format(_selectedDay),
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}
