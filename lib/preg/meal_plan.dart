import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/preg/mealplan_breakfast.dart';
import 'package:gab_ai/preg/mealplan_dinner.dart';
import 'package:gab_ai/preg/mealplan_lunch.dart';
import 'package:gab_ai/preg/mealplan_snacks.dart';

class MealPlanPage extends StatelessWidget {
  const MealPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: SystemColors.primaryColor,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: SystemColors.textColorDarker,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(icon: Image.asset('assets/icons/icon_breakfast_outlined.png', width: 28, height: 28)),
                  Tab(icon: Image.asset('assets/icons/icon_lunch_outlined.png', width: 28, height: 28)),
                  Tab(icon: Image.asset('assets/icons/icon_snacks_outlined.png', width: 28, height: 28)),
                  //Tab(icon: Image.asset('assets/icons/icon_dinner_outlined.png', width: 28, height: 28)),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    MealPlanBreakfast(),
                    MealPlanLunch(),
                    MealPlanSnacks(),
                    MealPlanDinner(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
