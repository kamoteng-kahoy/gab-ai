import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';

class AppointmentsList extends StatelessWidget {
  AppointmentsList({super.key});

  final List<String> names = [
    'Dr. John Doe',
    'Dr. Jane Smith',
    'Dr. Emily Johnson',
    'Dr. Michael Brown',
    'Dr. Linda Davis',
    'Dr. Robert Wilson'
  ];

  final List<String> avatarUrls = [
    'https://avatar.iran.liara.run/public/boy?username=John',
    'https://avatar.iran.liara.run/public/boy?username=Jane',
    'https://avatar.iran.liara.run/public/boy?username=Emily',
    'https://avatar.iran.liara.run/public/boy?username=Michael',
    'https://avatar.iran.liara.run/public/boy?username=Linda',
    'https://avatar.iran.liara.run/public/boy?username=Robert'
  ];

  final List<VoidCallback> cardFunctions = [
    () => print('Tapped on Dr. John Doe'),
    () => print('Tapped on Dr. Jane Smith'),
    () => print('Tapped on Dr. Emily Johnson'),
    () => print('Tapped on Dr. Michael Brown'),
    () => print('Tapped on Dr. Linda Davis'),
    () => print('Tapped on Dr. Robert Wilson'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.all(15),
        children: List.generate(6, (index) {
          return GestureDetector(
            onTap: cardFunctions[index],
            child: Card(
              color: SystemColors.bgWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(avatarUrls[index]),
                    radius: 35,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    names[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              )
            ),
          );
        }),
      ),
    );
  }
}