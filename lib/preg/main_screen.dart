import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/preg/appointments/appointments_main.dart';
import 'package:gab_ai/preg/journals/journals.dart';
import 'package:gab_ai/preg/settings/profile.dart';
import 'package:gab_ai/preg/settings/settings_page.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:gab_ai/preg/dashboard/dashboard.dart';
import 'package:gab_ai/login.dart';
import 'package:gab_ai/preg/meal%20plan/meal_plan.dart';

class MainScreen extends StatefulWidget {
  final int initialTabIndex;

  const MainScreen({Key? key, this.initialTabIndex = 0}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const MealPlanPage(),
    const AppointmentScreen(),
    const JournalsPage(),
    const SettingsPage()
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Appointments'),
    Text('Journals'),
    Text('Settings'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTabIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  void navigateToMealPlan() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  void navigateToAppointments() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  void navigateToJournals() {
    setState(() {
      _selectedIndex = 3;
    });
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 2:
        return 'Appointments';
      case 3:
        return 'Journals';
      case 4:
        return 'Settings';
      default:
        return '';
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: SystemColors.bgColorLighter,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AppBar(
              backgroundColor: SystemColors.bgColorLighter,
              centerTitle: true,
              title: Text(_getAppBarTitle(),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
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
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
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
                  setState(() {
                    _selectedIndex = 4;
                  });
                  Navigator.pop(context);
                }
              ),
              ListTile(
                leading: const Icon(FluentIcons.sign_out_24_filled),
                title: Text('Log out',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                onTap: () async {
                  bool? confirmLogout = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Logout'),
                        content: const Text('Are you sure you want to log out?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          TextButton(
                            child: const Text('Log out'),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      );
                    },
                  );
      
                  if (confirmLogout == true) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  }
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
                  icon: Icon(
                    _selectedIndex == 0 ? FluentIcons.home_24_filled : FluentIcons.home_24_regular,
                    color: _selectedIndex == 0 ? SystemColors.primaryColorDarker : SystemColors.textColor,
                  ),
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
                  icon: Icon(
                    _selectedIndex == 1 ? FluentIcons.food_24_filled : FluentIcons.food_24_regular,
                    color: _selectedIndex == 1 ? SystemColors.primaryColorDarker : SystemColors.textColor,
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
                  icon: Icon(
                    _selectedIndex == 2 ? FluentIcons.calendar_24_filled : FluentIcons.calendar_24_regular,
                    color: _selectedIndex == 2 ? SystemColors.primaryColorDarker : SystemColors.textColor,
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
                  icon: Icon(
                    _selectedIndex == 3 ? FluentIcons.book_24_filled : FluentIcons.book_24_regular,
                    color: _selectedIndex == 3 ? SystemColors.primaryColorDarker : SystemColors.textColor,
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
                  icon: Icon(
                    _selectedIndex == 4 ? FluentIcons.settings_24_filled : FluentIcons.settings_24_regular,
                    color: _selectedIndex == 4 ? SystemColors.primaryColorDarker : SystemColors.textColor,
                  ),
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
      ),
    );
  }
}
