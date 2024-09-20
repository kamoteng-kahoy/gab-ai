import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isNotificationsEnabled = true;
  bool _isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      body: Column(
        children: [
          const SizedBox(height: 30),
          ListTile(
            title: Text('Profile',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            leading: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: SystemColors.secondaryColor2,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Icon(FluentIcons.person_24_filled)
            ),
            onTap: () {
              // Handle profile tap
            },
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: SystemColors.secondaryColor2,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Icon(FluentIcons.alert_24_filled)
            ),
            title: Text('Notifications',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            trailing: Switch(
              value: _isNotificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _isNotificationsEnabled = !_isNotificationsEnabled;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: SystemColors.secondaryColor2,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Icon(FluentIcons.weather_moon_24_filled)
            ),
            title: Text('Dark Mode',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            trailing: Switch(
              value: _isDarkModeEnabled,
              onChanged: (bool value) {
                setState(() {
                  _isDarkModeEnabled = !_isDarkModeEnabled;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: SystemColors.secondaryColor2,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Icon(FluentIcons.sign_out_24_filled)
            ),
            title: Text('Log Out',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}