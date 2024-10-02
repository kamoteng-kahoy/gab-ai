import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/preg/appointments/booked_message.dart';

class BookedAppointments extends StatelessWidget {
  const BookedAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListedMessages(),
      ),
    );
  }
}

class ListedMessages extends StatelessWidget {
  const ListedMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int upcomingAppointments = 3; // Replace with the actual number of upcoming appointments
    List<Map<String, String>> appointments = [
      {
        'name': 'John Doe',
        'lastMessage': 'Message Here ...',
        'profilePicture': 'https://avatar.iran.liara.run/public/boy'
      },
      {
        'name': 'Jane Smith',
        'lastMessage': 'Message Here ...',
        'profilePicture': 'https://avatar.iran.liara.run/public/88'
      },
      {
        'name': 'Alice Johnson',
        'lastMessage': 'Message Here ...',
        'profilePicture': 'https://avatar.iran.liara.run/public/girl'
      },
    ];

    void onTapFunction(BuildContext context, int index) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookedMessage(
            name: appointments[index]['name']!,
            profilePicture: appointments[index]['profilePicture']!,
          ),
        ),
      );
    }

    return Column(
      children: List.generate(
        upcomingAppointments,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: InkWell(
            onTap: () => onTapFunction(context, index),
            child: Card(
              child: ListTile(
                leading: Image.network(appointments[index]['profilePicture']!),
                title: Text(
                  appointments[index]['name']!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(appointments[index]['lastMessage']!),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: BookedAppointments(),
  ));
}