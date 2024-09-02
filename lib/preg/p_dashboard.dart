import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    // Add your pages here
    // Example: HomePage(),
    //         NotificationsPage(),
    //         ProfilePage(),
  ];


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
          children: const [
            // Add your drawer items here
            // Example: ListTile(
            //           title: Text('Item 1'),
            //           onTap: () {
            //             // Handle item 1 tap
            //           },
            //         ),
            //         ListTile(
            //           title: Text('Item 2'),
            //           onTap: () {
            //             // Handle item 2 tap
            //           },
            //         ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const TextGreetings(),
              const SizedBox(height: 40.0),
              QuickNav(),
              const SizedBox(height: 20.0),
              const Divider(
                color: Colors.grey, // Set the color of the divider
                thickness: 0.5,// Set the thickness of the divider
                indent: 10.0, // Set the left indent
                endIndent: 10.0,
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Meal Plan',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              //const MealPlan(),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
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
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
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
          ],// Replace with a valid ConcreteBottomBarOption object
        ),
      ),
    );
  }
}

class TextGreetings extends StatelessWidget {
  const TextGreetings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Welcome to GAB-AI',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
          ),
          Opacity(
            opacity: 0.6,
            child: Text('Explore your nutrition journey with us.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuickNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNavButton(context, 'Meal Plan', 'assets/icons/icon_mealplan.png', _navigateToMealPlan),
        _buildNavButton(context, 'Appointments', 'assets/icons/icon_appointments.png', _navigateToAppointments),
        _buildNavButton(context, 'Journals', 'assets/icons/icon_journal.png', _navigateToJournals),
      ],
    );
  }

  Widget _buildNavButton(BuildContext context, String label, String imagePath, void Function(BuildContext) onPressed) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          width: 70,
          child: ElevatedButton(
            onPressed: () => onPressed(context),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              padding: const EdgeInsets.all(16.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  height: 30,
                  width: 30,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void _navigateToMealPlan(BuildContext context) {
    //Navigator.pushNamed(context, '/mealPlan');
    print('Navigating to Meal Plan');
  }

  void _navigateToAppointments(BuildContext context) {
    //Navigator.pushNamed(context, '/appointments');
    print('Navigating to Appointments');
  }

  void _navigateToJournals(BuildContext context) {
    //Navigator.pushNamed(context, '/journals');
    print('Navigating to Journals');
  }
}