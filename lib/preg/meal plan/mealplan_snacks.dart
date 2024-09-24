import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';

class MealPlanSnacks extends StatelessWidget {
  const MealPlanSnacks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
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
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/cover_photos/cover_snacks.jpg', // Replace with your image path
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
                  Text('Snacks',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 20
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Healthy snacks are essential for pregnant women because they provide vital nutrients needed for both the mother and the developing baby. Pregnancy increases nutritional demands, and snacking on nutrient-dense foods like fruits, vegetables, nuts, and whole grains can help maintain energy levels, support fetal growth, and promote healthy weight gain. Additionally, regular healthy snacks can help prevent common pregnancy issues like nausea, fatigue, and cravings, while also ensuring the mother gets adequate vitamins and minerals such as iron, calcium, and folic acid.',
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
                  const RecommendedFoodsCard(),
                  const SizedBox(height: 20)
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecommededFoodsCard(
          title: 'Rice',
          imagePath: 'assets/background_images/bg_rice.jpg', 
          description: '1 cup',
        ),
        RecommededFoodsCard(
          title: 'Egg', 
          imagePath: 'assets/background_images/bg_egg.jpg', 
          description: '1 piece',
        ),
        RecommededFoodsCard(
          title: 'Daing na Bisugo', 
          imagePath: 'assets/background_images/bg_dried-fish.jpg', 
          description: '½ pc of 15½ x 8 cm',
        ),
      ],
    );
  }
}

class RecommededFoodsCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;

  const RecommededFoodsCard({super.key, 
    required this.title, 
    required this.imagePath,
    required this.description
    });

  @override
  Widget build(BuildContext context) {
    return Card(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white, 
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 15
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
