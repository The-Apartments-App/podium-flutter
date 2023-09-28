import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MaintenanceTechDashboardCalendar extends StatefulWidget {
  const MaintenanceTechDashboardCalendar({super.key});

  @override
  State<MaintenanceTechDashboardCalendar> createState() =>
      _MaintenanceTechDashboardCalendarState();
}

class _MaintenanceTechDashboardCalendarState
    extends State<MaintenanceTechDashboardCalendar> {
  DateTime? _selectedDay;
  var _focusedDay = DateTime.now().toUtc().add(const Duration(hours: 7));
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final kToday = DateTime.now();
    final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

    final kEventSource = {
      for (var item in List.generate(50, (index) => index))
        DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
            item % 4 + 1, (index) => Event('Event $item | ${index + 1}'))
    }..addAll({
        kToday: [
          const Event("Today's Event 1"),
          const Event("Today's Event 2"),
        ],
      });

    int getHashCode(DateTime key) {
      return key.day * 1000000 + key.month * 10000 + key.year;
    }

    final kEvents = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(kEventSource);

    // List<Event> _getEventsForDay(DateTime day) {
      // Implementation example
    //   return kEvents[day] ?? [];
    // }

    return TableCalendar<DateTime>(
      // eventLoader: _getEventsForDay,
      focusedDay: _focusedDay,
      firstDay: kFirstDay,
      lastDay: kLastDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarFormat: _calendarFormat,
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }
}

class Event {
  const Event(this.title);
  final String title;

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.

