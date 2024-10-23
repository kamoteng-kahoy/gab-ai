import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/preg/appointments/booked_message.dart';

class BookedDetails extends StatelessWidget {
  final String name;
  final String profilePicture;

  const BookedDetails({super.key, required this.name, required this.profilePicture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      appBar: AppBar(
        title: Text('My Appointment',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        backgroundColor: SystemColors.bgColorLighter,
        elevation: 0,
        shadowColor: Colors.transparent, // Removes shadow when scrolling
        scrolledUnderElevation: 0, // Prevents shadow when scrolling
        leading: IconButton(
          icon: const Icon(FluentIcons.arrow_left_24_filled),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        toolbarHeight: 70,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Info Card
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(profilePicture),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Nutritionist-Dietician',
                    style: TextStyle(fontSize: 16),
                  ),
                ]
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const AppointmentDetails(),
            const SizedBox(height: 40),
            const PatientInformation(),
            const SizedBox(height: 60),
            Center(
              child: SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
                    backgroundColor: SystemColors.primaryColorDarker,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    _navigateToBookedMessage(context, name, profilePicture);
                  },
                  child: const Text(
                    'Message (Start at 16:00 PM)',
                    style: TextStyle(
                      fontSize: 16, 
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToBookedMessage(BuildContext context, String name, String profilePicture) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookedMessage(name: name, profilePicture: profilePicture),
      ),
    );
  }
}

class AppointmentDetails extends StatelessWidget {
  const AppointmentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Scheduled Appointment',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              const Icon(FluentIcons.calendar_24_regular, size: 24),
              const SizedBox(width: 10),
              Text('Date', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold, 
                )
              ),
              const Spacer(),
              Text('Monday, 12th July 2021', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
              )),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              const Icon(FluentIcons.clock_24_regular, size: 24),
              const SizedBox(width: 10),
              Text('Time', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text('8:00 am - 8:30 am', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16)
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PatientInformation extends StatelessWidget {
  const PatientInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Patient Information',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Text('Name', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )
              ),
              const Spacer(),
              Text('Alice Going', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16)
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Text('Weeks Pregnant', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )
              ),
              const Spacer(),
              Text('21-25 weeks', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16)
              ),
            ],
          ),
        ),
      ],
    );
  }
}