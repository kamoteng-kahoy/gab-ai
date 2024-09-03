import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/preg/main_screen.dart';
import 'package:gab_ai/preg/meal_plan.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class HomePage extends StatefulWidget {
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
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const SizedBox(height: 10.0),
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
              const MealPlanSummary(),
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
    return Column(
      children: [
        _buildMealCard('Breakfast', 'assets/default.png'),
        const SizedBox(height: 10),
        _buildMealCard('Lunch', 'assets/default.png'),
        const SizedBox(height: 10),
        _buildMealCard('Snacks', 'assets/default.png'),
        const SizedBox(height: 10),
        _buildMealCard('Dinner', 'assets/default.png'),
      ],
    );
  }

  Widget _buildMealCard(String mealType, String imagePath) {
    return Card(
      color: SystemColors.secondaryColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              mealType,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}