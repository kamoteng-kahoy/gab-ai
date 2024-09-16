import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewAppointments(),
    );
  }
}

class NewAppointments extends StatefulWidget {
  @override
  _NewAppointmentsState createState() => _NewAppointmentsState();
}

class _NewAppointmentsState extends State<NewAppointments> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      appBar: AppBar(
        title: Text('New Appointment',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: SystemColors.bgColorLighter,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(FluentIcons.arrow_left_20_filled),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const DatePicker(),
              const SizedBox(height: 20),
              TimePicker(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  final List<int> _years = List<int>.generate(10, (i) => DateTime.now().year + i);
  String _selectedMonth = 'January';
  int _selectedYear = DateTime.now().year;
  int _daysInMonth = 31;
  int? _selectedDate; // Define the _selectedDate variable

  @override
  void initState() {
    super.initState();
    _updateDaysInMonth();
  }

  void _updateDaysInMonth() {
    final monthIndex = _months.indexOf(_selectedMonth) + 1;
    final lastDayDateTime = DateTime(_selectedYear, monthIndex + 1, 0);
    setState(() {
      _daysInMonth = lastDayDateTime.day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButton<String>(
                value: _selectedMonth,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedMonth = newValue!;
                    _updateDaysInMonth();
                  });
                },
                items: _months.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  );
                }).toList(),
                underline: const SizedBox.shrink(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButton<int>(
                value: _selectedYear,
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedYear = newValue!;
                    _updateDaysInMonth();
                  });
                },
                items: _years.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  );
                }).toList(),
                underline: const SizedBox.shrink(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _daysInMonth,
            itemBuilder: (context, index) {
              final date = index + 1;
              final day = DateTime(_selectedYear, _months.indexOf(_selectedMonth) + 1, date).weekday;
              final dayName = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][day - 1];
              final isSelected = _selectedDate == date;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                child: Card(
                  color: isSelected ? SystemColors.primaryColorDarker : Colors.white,
                  child: Container(
                    width: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          date.toString(),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          dayName,
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TimePicker extends StatefulWidget {
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  List<String> _timeSlots = [];
  String? _selectedTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _generateTimeSlots();
  }

  void _generateTimeSlots() {
    final times = <String>[];
    for (int hour = 0; hour < 24; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        final time = TimeOfDay(hour: hour, minute: minute);
        final formattedTime = time.format(context);
        times.add(formattedTime);
      }
    }
    setState(() {
      _timeSlots = times;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200, // Set a fixed height for the GridView
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: _timeSlots.length,
            itemBuilder: (context, index) {
              final time = _timeSlots[index];
              final isSelected = _selectedTime == time;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTime = time;
                  });
                },
                child: Card(
                  color: isSelected ? Colors.blue : Colors.white,
                  child: Center(
                    child: Text(
                      time,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}