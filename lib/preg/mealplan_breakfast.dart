import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';

class MealPlanBreakfast extends StatelessWidget {
  const MealPlanBreakfast({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: SystemColors.bgColorLighter,

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Today\'s Breakfast:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Oatmeal with fruits and nuts',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Scrambled eggs with toast',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Yogurt with granola',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}