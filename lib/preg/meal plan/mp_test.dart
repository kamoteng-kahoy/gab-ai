import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GenerateMealPlanScreen extends StatefulWidget {
  const GenerateMealPlanScreen({super.key});

  @override
  _GenerateMealPlanScreenState createState() => _GenerateMealPlanScreenState();
}

class _GenerateMealPlanScreenState extends State<GenerateMealPlanScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController trimesterController = TextEditingController();

  // Multi-select lists for dietary preferences and health conditions
  List<String> selectedDietaryPreferences = [];
  List<String> selectedHealthConditions = [];

  bool isLoading = false;
  String mealPlanResult = '';

  // Options for dietary preferences and health conditions
  final List<String> dietaryOptions = ['Vegetarian', 'Vegan', 'Gluten-Free', 'Keto'];
  final List<String> healthConditionOptions = ['Diabetes', 'Hypertension', 'Allergies'];

  Future<void> generateMealPlan() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Send a POST request to the Python FastAPI backend with a longer timeout
      final response = await http
          .post(
            Uri.parse('http://10.0.2.2:8000/generate_meal_plan'), // For Android emulator
            headers: <String, String>{'Content-Type': 'application/json'},
            body: jsonEncode(<String, dynamic>{
              'age': int.parse(ageController.text),
              'weight': double.parse(weightController.text),
              'height': double.parse(heightController.text),
              'trimester': int.parse(trimesterController.text),
              'dietary_preferences': selectedDietaryPreferences,
              'health_conditions': selectedHealthConditions,
            }),
          );
          //.timeout(const Duration(seconds: 120)); // Set a 60-second timeout

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        setState(() {
          mealPlanResult = jsonResponse['meal_plan'];  // Display meal plan result in UI
        });
      } else {
        setState(() {
          mealPlanResult = 'Error: Failed to generate meal plan (Status code: ${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        mealPlanResult = 'Error: $e';
        print(e);
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate Meal Plan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Age"),
            ),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Weight (kg)"),
            ),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Height (cm)"),
            ),
            TextField(
              controller: trimesterController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Trimester (weeks)"),
            ),
            const SizedBox(height: 16),
            const Text("Dietary Preferences"),
            Wrap(
              spacing: 8.0,
              children: dietaryOptions.map((option) {
                return FilterChip(
                  label: Text(option),
                  selected: selectedDietaryPreferences.contains(option),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedDietaryPreferences.add(option);
                      } else {
                        selectedDietaryPreferences.remove(option);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text("Health Conditions"),
            Wrap(
              spacing: 8.0,
              children: healthConditionOptions.map((option) {
                return FilterChip(
                  label: Text(option),
                  selected: selectedHealthConditions.contains(option),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedHealthConditions.add(option);
                      } else {
                        selectedHealthConditions.remove(option);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : generateMealPlan,
              child: Text(isLoading ? 'Generating...' : 'Generate Meal Plan'),
            ),
            const SizedBox(height: 16),
            Text(
              mealPlanResult.isNotEmpty ? "Meal Plan: $mealPlanResult" : '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
