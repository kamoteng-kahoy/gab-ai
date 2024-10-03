import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/preg/settings/edit_personal_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PersonalInfoScreen(),
    );
  }
}

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      appBar: AppBar(
        title: Text('Personal Information',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: SystemColors.bgColorLighter,
        leading: IconButton(
          icon: const Icon(FluentIcons.arrow_left_20_filled),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileInfo(),
                  SizedBox(height: 40),
                  MainInfoCard(),
                  SizedBox(height: 40),
                  OtherInfo(),
                ],
              ),
            ),
          ),
          EditButton(),
        ],
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage('https://avatar.iran.liara.run/public/girl'), // Replace with your image asset
          ),
          const SizedBox(height: 20),
          Text(
            'Alice Doe', // Replace with the actual name
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class MainInfoCard extends StatelessWidget {
  const MainInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoBox(context, 'Age', '25'),
          _buildInfoBox(context, 'Weight', '80 kg'),
          _buildInfoBox(context, 'Height', '150 cm'),
        ],
      ),
    );
  }

  Widget _buildInfoBox(BuildContext context, String title, String subtitle){
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: SystemColors.secondaryColor2,
        borderRadius: BorderRadius.circular(21),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OtherInfo extends StatelessWidget {
  const OtherInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> otherInfoList = [
      {'title': 'Trimester', 'value': '2nd Trimester'},
      {'title': 'Address', 'value': '123 Main Street, Davao City'},
      {'title': 'Phone Number', 'value': '+639123456789'},
      {'title': 'Email', 'value': 'alicedoe@gmail.com'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: otherInfoList.map((info) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                info['title']!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                info['value']!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditPersonalInfo()),
            );
          },
          backgroundColor: SystemColors.primaryColorDarker,
          child: const Icon(FluentIcons.edit_20_filled,
            color: Color(0xFFFDFDFD),
          ),
        ),
      ),
    );
  }
}