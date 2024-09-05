import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/preg/preferences_personal-info.dart';
import 'package:intl/intl.dart';
import 'package:gab_ai/preg/mealplan_breakfast.dart';
import 'package:gab_ai/preg/mealplan_dinner.dart';
import 'package:gab_ai/preg/mealplan_lunch.dart';
import 'package:gab_ai/preg/mealplan_snacks.dart';

class MealPlanPage extends StatelessWidget {
  const MealPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentDate = DateFormat('MMMM dd, yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Meal Plan for Today',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 26
                ),
              ),
              const SizedBox(height: 5),
              Text(
                currentDate,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: Colors.grey,
              ),
            ),
              const SizedBox(height: 20),
              const MealPlanCard(),
              const SizedBox(height: 30),
              const PreferencesButton(),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}

class MealPlanCard extends StatelessWidget {
  const MealPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MealCard(
          title: 'Breakfast',
          imagePath: 'assets/background_images/bg_breakfast.jpg', 
          onTap: () { 
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MealPlanBreakfast()),
            );
          },
        ),
        MealCard(
          title: 'Lunch', 
          imagePath: 'assets/background_images/bg_lunch.jpg', 
          onTap: () { 
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MealPlanLunch()),
            );
          },
        ),
        MealCard(
          title: 'Snacks', 
          imagePath: 'assets/background_images/bg_snacks.jpg', 
          onTap: () { 
            print('Snacks');
          },
        ),
        MealCard(
          title: 'Dinner', 
          imagePath: 'assets/background_images/bg_dinner.jpg', 
          onTap: () { 
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MealPlanDinner())
            );
          },
        ),
      ],
    );
  }
}

class MealCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const MealCard({super.key, 
    required this.title, 
    required this.imagePath, 
    required this.onTap
    });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
        ),
        child: SizedBox(
          height: 120,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: const LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Ensure text is visible on the image
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PreferencesButton extends StatelessWidget {
  const PreferencesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Have specific preferences?"),
        TextButton(
          onPressed: () {
            // Navigate to Register As screen
            print('Pressed');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>PreferencesPersonal()),
            );
          },
          child: const Padding(
            padding: EdgeInsets.zero,
            child: Text('Set Here'),
          ),
        ),
      ],
    );
  }
}
