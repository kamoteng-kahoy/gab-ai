import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:gab_ai/preg/home_page.dart';
import 'package:gab_ai/login.dart';
import 'package:gab_ai/preg/meal_plan.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    MealPlanPage(),
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            leading: Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: const CircleAvatar(
                  radius: 10,
                  backgroundImage: NetworkImage('https://avatar.iran.liara.run/public'), // Replace with the actual profile image URL
                ),
              ),
            ),
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: const Icon(FluentIcons.alert_20_regular),
              onSelected: (String result) {
                // Handle notification selection
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Notification 1',
                  child: Text('Notification 1'),
                ),
                const PopupMenuItem<String>(
                  value: 'Notification 2',
                  child: Text('Notification 2'),
                ),
                const PopupMenuItem<String>(
                  value: 'Notification 3',
                  child: Text('Notification 3'),
                ),
                // Add more notifications here
              ],
            ),
          ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [SystemColors.secondaryColor2, SystemColors.bgColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://avatar.iran.liara.run/public'), // Replace with the actual profile image URL
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Account Name',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(FluentIcons.person_24_filled),
              title: Text('Profile',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                // Handle the tap event
              },
            ),
            ListTile(
              leading: const Icon(FluentIcons.settings_24_filled),
              title: Text('Settings',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                // Handle the tap event
              },
            ),
            ListTile(
              leading: const Icon(FluentIcons.sign_out_24_filled),
              title: Text('Log out',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: SizedBox(
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