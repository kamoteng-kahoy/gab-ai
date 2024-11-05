import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';

class MealPlanLunch extends StatelessWidget {
  const MealPlanLunch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent, // Removes shadow when scrolling
        scrolledUnderElevation: 0, // Prevents shadow when scrolling
        title: Image.asset('assets/logo-word.png',
          height: 40,
        ),
        backgroundColor: SystemColors.bgColorLighter,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(FluentIcons.arrow_left_20_filled),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        toolbarHeight: 70,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/cover_photos/cover_lunch.jpg', // Replace with your image path
              height: 200, // Adjust the height as needed
              width: double.infinity, // Adjust the width as needed
              fit: BoxFit.cover, // Adjust the fit as needed
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lunch',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 20
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Healthy lunch is crucial for pregnant women as it provides essential nutrients that support both maternal health and the baby\'s development. A balanced meal rich in vitamins, minerals, and protein helps maintain energy levels, supports proper fetal growth, and reduces the risk of complications. Including fruits, vegetables, whole grains, and lean proteins ensures that the mother and baby get the necessary nutrients for a healthy pregnancy.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.5)
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text('Recommended Foods',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const RecommendedFoodsCard(),
                  const SizedBox(height: 30)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecommendedFoodsCard extends StatelessWidget {
  const RecommendedFoodsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> foods = [
      {'title': 'Rice', 'subtitle': '1 cup'},
      {'title': 'Egg', 'subtitle': '1 piece'},
      {'title': 'Daing na Bisugo', 'subtitle': '½ pc of 15½ x 8 cm'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: foods.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          color: SystemColors.accentColor2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    foods[index]['title']!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    foods[index]['subtitle']!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 14,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}