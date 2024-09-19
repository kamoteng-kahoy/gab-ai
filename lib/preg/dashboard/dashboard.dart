import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/preg/main_screen.dart';
import 'package:gab_ai/preg/meal%20plan/mealplan_breakfast.dart';
import 'package:gab_ai/preg/meal%20plan/mealplan_dinner.dart';
import 'package:gab_ai/preg/meal%20plan/mealplan_lunch.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              const TextGreetings(),
              const SizedBox(height: 40.0),
              const QuickNav(),
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
                  'Meal Plan for Today',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const MealPlanSummary(),
              const SizedBox(height: 40.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Upcoming Appointments',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20.0), // Add a space at the end.
              const AppointmentsSummary(),
              const SizedBox(height: 40.0),
            ],
          ),
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
  const QuickNav({super.key});

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
              shadowColor: Colors.black.withOpacity(0.9),
              elevation: 5.0,
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
  final mainScreenState = context.findAncestorStateOfType<MainScreenState>();
  if (mainScreenState != null) {
    mainScreenState.navigateToMealPlan();
  }
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

class MealPlanSummary extends StatelessWidget {
  const MealPlanSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.4;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: IconButton(
                icon: Container(
                  width: buttonWidth,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF0E68C),Color(0xFFFFE4B5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/icon_breakfast_outlined.png', width: 30, height: 30),
                      const SizedBox(height: 10),
                      const Text('Breakfast'),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MealPlanBreakfast()),
                  );
                },
                tooltip: 'Breakfast',
              ),
            ),
            Flexible(
              child: IconButton(
                icon: Container(
                  width: buttonWidth,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF90EE90),Color(0xFF98FB98)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/icon_lunch_outlined.png', width: 30, height: 30),
                      const SizedBox(height: 10),
                      const Text('Lunch'),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MealPlanLunch()),
                  );
                },
                tooltip: 'Lunch',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: IconButton(
                icon: Container(
                  width: buttonWidth,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD2B48C),Color(0xFFFFA54F)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/icon_snacks_outlined.png', width: 30, height: 30),
                      const SizedBox(height: 10),
                      const Text('Snacks'),
                    ],
                  ),
                ),
                onPressed: () {},
                tooltip: 'Snacks',
              ),
            ),
            Flexible(
              child: IconButton(
                icon: Container(
                  width: buttonWidth,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF87CEEB),Color(0xFFC6E2FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/icon_dinner_outlined.png', width: 30, height: 30),
                      const SizedBox(height: 10),
                      const Text('Dinner'),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MealPlanDinner()),
                  );
                },
                tooltip: 'Dinner',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AppointmentsSummary extends StatelessWidget {
  const AppointmentsSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int upcomingAppointments = 3; // Replace with the actual number of upcoming appointments
    List<Map<String, String>> appointments = [
      {
        'name': 'John Doe',
        'date': DateTime.now().add(const Duration(days: 1)).toString().split(' ')[0],
        'profilePicture': 'https://avatar.iran.liara.run/public/boy'
      },
      {
        'name': 'Jane Smith',
        'date': DateTime.now().add(const Duration(days: 2)).toString().split(' ')[0],
        'profilePicture': 'https://avatar.iran.liara.run/public/88'
      },
      {
        'name': 'Alice Johnson',
        'date': DateTime.now().add(const Duration(days: 3)).toString().split(' ')[0],
        'profilePicture': 'https://avatar.iran.liara.run/public/girl'
      },
    ];

    List<void Function()> onTapFunctions = [
      () {
        // Function for the first card
        print('Card tapped: John Doe');
      },
      // Add more functions for other cards here
      (){
        print('Card tapped: Jane Smith');
      },
      (){
        print('Card tapped: Alice Johnson');
      }
    ];

    return Column(
      children: List.generate(
        upcomingAppointments,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: InkWell(
            onTap: onTapFunctions[index],
            child: Card(
              child: ListTile(
                leading: Image.network(appointments[index]['profilePicture']!),
                title: Text(
                  appointments[index]['name']!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text('Date: ${appointments[index]['date']}'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}