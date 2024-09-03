import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';

class MealPlanLunch extends StatelessWidget {
  const MealPlanLunch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: SystemColors.bgColorLighter,

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Lunch Content'),
            ],
          ),
        ),
      ),
    );
  }
}