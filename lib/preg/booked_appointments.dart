import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/preg/booked_message.dart';

class BookedAppointments extends StatelessWidget {
  const BookedAppointments({super.key});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 10, // Replace with the actual number of messages
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text((index + 1).toString()),
              ),
              title: Text('Message ${index + 1}'),
              subtitle: const Text('This is a sample message.'),
              onTap: () => _handleMessageTap(context),
            );
          },
        ),
      ),
    );
  }

  void _handleMessageTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookedMessage()),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: BookedAppointments(),
  ));
}