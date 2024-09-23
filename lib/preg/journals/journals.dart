import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/preg/journals/create_journal.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JournalsPage(),
    );
  }
}

class JournalsPage extends StatefulWidget {
  const JournalsPage({super.key});

  @override
  _JournalsPageState createState() => _JournalsPageState();
}

class _JournalsPageState extends State<JournalsPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<Map<String, dynamic>>> _events = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      body: Column(
        children: [
          CustomTableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDay: _selectedDay,
            events: _events,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
            weeksRowHeight: 30.0,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Expanded(
            child: EventList(
              events: _getEventsForDay(_selectedDay ?? _focusedDay),
              onEventTap: (event) {
                // Handle event click
                print('Event clicked: $event');
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewJournal(),
            ),
          );

          if (result != null) {
            setState(() {
              final event = result as Map<String, dynamic>;
              final date = event['createdTime'] as DateTime;
              final eventDate = DateTime(date.year, date.month, date.day); // Normalize to date only
              if (_events[eventDate] == null) {
                _events[eventDate] = [];
              }
              _events[eventDate]!.add(event);
            });
          }
        },
        backgroundColor: SystemColors.primaryColorDarker,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Icon(FluentIcons.add_24_filled,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day); // Normalize to date only
    return _events[normalizedDay] ?? [];
  }
}

class CustomTableCalendar extends StatelessWidget {
  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final DateTime? selectedDay;
  final Map<DateTime, List<Map<String, dynamic>>> events;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final Function(DateTime) onPageChanged;
  final double weeksRowHeight;

  const CustomTableCalendar({
    super.key,
    required this.firstDay,
    required this.lastDay,
    required this.focusedDay,
    required this.calendarFormat,
    required this.selectedDay,
    required this.events,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.onPageChanged,
    this.weeksRowHeight = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: firstDay,
      lastDay: lastDay,
      focusedDay: focusedDay,
      calendarFormat: calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
      eventLoader: (day) {
        final normalizedDay = DateTime(day.year, day.month, day.day);
        return events[normalizedDay] ?? [];
      },
      onDaySelected: onDaySelected,
      onFormatChanged: onFormatChanged,
      onPageChanged: onPageChanged,
      daysOfWeekHeight: weeksRowHeight,
      calendarStyle: const CalendarStyle(),
      calendarBuilders: CalendarBuilders(
        todayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: SystemColors.primaryColorDarker, width: 2.0),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(
              date.day.toString(),
              style: const TextStyle(color: SystemColors.primaryColorDarker),
            ),
          );
        },
        selectedBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: SystemColors.primaryColorDarker,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(
              date.day.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            return Positioned(
              bottom: 1,
              child: _buildEventsMarker(date, events),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: SystemColors.primaryColor,
      ),
      width: 10.0,
      height: 10.0,
      child: Center(
        child: Text(
          '',
          style: const TextStyle().copyWith(
            color: SystemColors.textColor,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class EventList extends StatelessWidget {
  final List<Map<String, dynamic>> events;
  final Function(Map<String, dynamic>) onEventTap;

  const EventList({
    super.key,
    required this.events,
    required this.onEventTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height, // Set a specific height or use MediaQuery to get screen height
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            final createdTime = event['createdTime'] as DateTime?;
            final formattedTime = createdTime != null
                ? DateFormat('hh:mm a').format(createdTime)
                : 'No Time';

            return GestureDetector(
              onTap: () => onEventTap(event),
              child: Card(
                color: SystemColors.accentColor2,
                child: ListTile(
                  title: Text(
                    event['category'] ?? 'No Category',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    formattedTime,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: Colors.grey
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}