import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/preg/appointments_done.dart';

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
            fontSize: 22,
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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              DatePicker(),
              SizedBox(height: 30),
              TimePicker(),
              SizedBox(height: 30),
              PatientDetails(),
              SizedBox(height: 60),
              SetAppointmentButton(),
              SizedBox(height: 40)
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
  const TimePicker({super.key});

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
    for (int hour = 8; hour <= 20; hour++) { // Start at 8 AM and end at 8 PM
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
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('Set Time',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200, // Set a fixed height for the GridView
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1, // Adjust the aspect ratio as needed
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
                child: SizedBox(
                  width: 120, // Adjust the width as needed
                  height: 50, // Adjust the height as needed
                  child: Card(
                    color: isSelected ? SystemColors.primaryColorDarker : Colors.white,
                    child: Center(
                      child: Text(
                        time,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
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

class PatientDetails extends StatefulWidget {
  const PatientDetails({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  String _name = "John Doe"; // Replace with the actual logged-in user's name
  int _selectedAge = 18;
  String? _selectedWeeksPregnant;
  String? selectedInterval;

  @override
  Widget build(BuildContext context) {
    List<String> ageIntervals = [];
    for (int i = 18; i <= 55; i += 4) {
      int end = (i + 3 > 55) ? 55 : i + 3;
      ageIntervals.add('$i-$end');
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Patient Details',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            'Full Name',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('$_name',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Age',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: DropdownButton<String>(
                isExpanded: true,
                value: (selectedInterval?.isEmpty ?? true) ? ageIntervals.first : selectedInterval,
                hint: Text(
                  ageIntervals.first,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 18,
                  ),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedInterval = newValue!;
                  });
                },
                items: ageIntervals.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      '$value years',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  );
                }).toList(),
                underline: const SizedBox.shrink(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Weeks Pregnant',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
           child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedWeeksPregnant,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedWeeksPregnant = newValue!;
                });
              },
              items: List<String>.generate(8, (i) {
                int start = i * 5 + 1;
                int end = start + 5 - 1;
                return '$start-$end weeks';
              }).map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                );
              }).toList(),
              underline: const SizedBox.shrink(),
            ),
          ),
          ),
        ],
      ),
    );
  }
}

class SetAppointmentButton extends StatefulWidget {
  const SetAppointmentButton({Key? key}) : super(key: key);

  @override
  _SetAppointmentButtonState createState() => _SetAppointmentButtonState();
}

class _SetAppointmentButtonState extends State<SetAppointmentButton> {
  bool _isLoading = false;

  void _setAppointment() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a network request or any async operation
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Show a success message
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => const DoneScreen()
      ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _setAppointment,
        style: ElevatedButton.styleFrom(
          backgroundColor: SystemColors.primaryColorDarker,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: _isLoading
          ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
          )
          : const Text(
              'Set Appointment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: SystemColors.bgWhite),
            ),
      ),
    );
  }
}