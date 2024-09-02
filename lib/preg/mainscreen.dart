import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:gab_ai/preg/homepage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    HomePage(),
    NotificationsPage(),
    ProfilePage(),
    AppointmentsPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: StylishBottomBar(
          backgroundColor: SystemColors.bgColorLighter,
          option: AnimatedBarOptions(
            iconSize: 28,
            barAnimation: BarAnimation.fade,
            iconStyle: IconStyle.animated,
            opacity: 0.3,
          ),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomBarItem(
                icon: Icon(FluentIcons.home_24_filled,
                  color: _selectedIndex == 0 ? SystemColors.primaryColorDarker : SystemColors.textColor),
                selectedIcon: const Icon(FluentIcons.home_24_filled,
                  color: SystemColors.primaryColorDarker,
                ),
                title: Text('Dashboard',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: SystemColors.primaryColorDarker,
                  ),
                ),
              ),
              BottomBarItem(
                icon: Icon(FluentIcons.food_24_filled,
                  color: _selectedIndex == 1 ? SystemColors.primaryColorDarker : SystemColors.textColor),
                selectedIcon: const Icon(FluentIcons.food_24_filled,
                  color: SystemColors.primaryColorDarker,
                ),
                title: Text('Meal Plan',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: SystemColors.primaryColorDarker,
                  ),
                ),
              ),
              BottomBarItem(
                icon: Icon(FluentIcons.calendar_24_filled,
                color: _selectedIndex == 2 ? SystemColors.primaryColorDarker : SystemColors.textColor),
                selectedIcon: const Icon(FluentIcons.calendar_24_filled,
                  color: SystemColors.primaryColorDarker,
                ),
                title: Text('Appointments',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: SystemColors.primaryColorDarker,
                    ),
                ),
              ),
              BottomBarItem(
                icon: Icon(FluentIcons.book_24_filled,
                  color: _selectedIndex == 3 ? SystemColors.primaryColorDarker : SystemColors.textColor),
                selectedIcon: const Icon(FluentIcons.calendar_24_filled,
                  color: SystemColors.primaryColorDarker,
                ),
                title: const Text('Journals',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: SystemColors.primaryColorDarker,
                  ),
                ),
              ),
              BottomBarItem(
                icon: Icon(FluentIcons.settings_24_filled,
                  color: _selectedIndex == 4 ? SystemColors.primaryColorDarker : SystemColors.textColor),
                selectedIcon: const Icon(FluentIcons.settings_24_filled,
                  color: SystemColors.primaryColorDarker,
                ),
                title: const Text('Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: SystemColors.primaryColorDarker,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}


class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notifications Page'),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Page'),
    );
  }
}

class AppointmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Journals Page'),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Page'),
    );
  }
}