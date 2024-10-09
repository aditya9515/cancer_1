import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class visitScreen extends StatefulWidget {
  const visitScreen({super.key});

  @override
  State<visitScreen> createState() => _visitScreenState();
}

class _visitScreenState extends State<visitScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(16.0),
            child: TableCalendar(
              firstDay: DateTime.utc(2022, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: DateTime.now(),
              selectedDayPredicate: (day) {
                return isSameDay(day, DateTime.now());
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );

  }
}