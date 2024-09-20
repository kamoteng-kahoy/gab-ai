import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/preg/appointments/new_appointments.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfileDetails(),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  final String name = "John Doe";
  final String about = "Mr. John Doe, RND is a top registered nutritional dietitian at Davao Doctors Hospital in Davao City, Philippines. He has achieved several awards and recognition for his contributions and service in the field of nutrition and dietetics.";
  final String workingTime = "Mon - Sat (9:00 am - 5:00 pm)";

  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(name: name),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListTile(
                  title: Text('About',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(about),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListTile(
                  title: Text('Working Time',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(workingTime),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListTile(
                  title: Text('Communication',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const CommunicationCard(),
              const SizedBox(height: 80),
              const BookAppointmentButton(),
              const SizedBox(height: 40),
            ]),
          ),
        ],
      ),
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  final String name;

  const CustomSliverAppBar({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      leading: IconButton(
        icon: const Icon(FluentIcons.arrow_left_20_filled),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Calculate the opacity based on the scroll offset
          final double opacity = (constraints.biggest.height - kToolbarHeight) / (250.0 - kToolbarHeight);
          return FlexibleSpaceBar(
            centerTitle: true,
            title: opacity < 0.5 ? Text(name) : null,
            background: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [SystemColors.secondaryColor2, SystemColors.bgColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://avatar.iran.liara.run/public/boy?username=John'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'John Doe',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CommunicationCard extends StatelessWidget {
  const CommunicationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        color: SystemColors.secondaryColor2,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Image.asset('assets/icons/icon_message-2.png',
                  width: 50,
                  height: 30,
                ),
                title: Text('Messaging',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                subtitle: const Text('Chat me up, share photos.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookAppointmentButton extends StatelessWidget {
  const BookAppointmentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: SizedBox(
        width: 100,
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewAppointments()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: SystemColors.primaryColorDarker,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text('Book Appointment',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: SystemColors.bgWhite
            ),
          ),
        ),
      ),
    );
  }
}