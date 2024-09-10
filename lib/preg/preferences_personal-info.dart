import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class PreferencesPersonal extends StatelessWidget {
  const PreferencesPersonal({super.key});

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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dietary Preferences',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Please provide your personal information, for a more accurate meal plan.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              const PersonalInfoInput(),
              const SizedBox(height: 30),
              const DietaryPreferencesInput(),
              const SizedBox(height: 30),
              const HealhConditionsInput(),
              const SizedBox(height: 60),
              const SubmitButton(),
              const SizedBox(height: 40),
            ],
          ),
        ),    
      ),
    );
  }
}

class PersonalInfoInput extends StatefulWidget {
  const PersonalInfoInput({super.key});


  @override
  State<PersonalInfoInput> createState() => _PersonalInfoInputState();
}

class _PersonalInfoInputState extends State<PersonalInfoInput> {
  String _selectedWeightUnit = 'kg'; // State variable to hold the selected value
  String _selectedTrimester = '1st trimester (weeks 1-12)'; // State variable to hold the selected value
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Personal Information',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Age',
                    labelStyle: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Weight',
                    labelStyle: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              Text('in',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 12),
              DropdownButton<String>(
                value: _selectedWeightUnit,
                items: <String>['kg', 'lbs'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedWeightUnit = newValue!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Height in cm',
              labelStyle: TextStyle(
                fontSize: 16,
              ),
            ),
            style: TextStyle(
              fontSize: 16,
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Trimester during pregnancy',
              labelStyle: TextStyle(
                fontSize: 16,
              ),
            ),
            value: _selectedTrimester,
            items: <String>['1st trimester (weeks 1-12)', '2nd trimester (weeks 13-28)', '3rd trimester (weeks 29-40)'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedTrimester = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }
}

class DietaryPreferencesInput extends StatefulWidget {
  const DietaryPreferencesInput({super.key});


  @override
  State<DietaryPreferencesInput> createState() => _DietaryPreferencesInputState();
}

class _DietaryPreferencesInputState extends State<DietaryPreferencesInput> {
  final List<String> _selectedPreferences = []; // State variable to hold the selected preferences

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dietary Preferences',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            children: _buildPreferenceChips(),
          ),
          const SizedBox(height: 15),
          const TextField(
            decoration: InputDecoration(
              labelText: 'If Others, please specify',
              labelStyle: TextStyle(
                fontSize: 16,
              ),
              border: UnderlineInputBorder(),
            ),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPreferenceChips() {
    final preferences = [
      'Vegetarian',
      'Vegan',
      'Gluten-free',
      'Dairy-free',
      'Nut-free',
      'Shellfish-free',
      'Others',
    ];

    return preferences.map((preference) {
      final isSelected = _selectedPreferences.contains(preference);

      return ChoiceChip(
        label: Text(preference,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 16,
          ),
        ),
        selected: isSelected,
        selectedColor: SystemColors.primaryColor,
        disabledColor: Colors.grey[300],
        backgroundColor: SystemColors.secondaryColor2,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _selectedPreferences.add(preference);
            } else {
              _selectedPreferences.remove(preference);
            }
          });
        },
      );
    }).toList();
  }
}


class HealhConditionsInput extends StatefulWidget {
  const HealhConditionsInput({super.key});

  @override
  State<HealhConditionsInput> createState() => _HealhConditionsInputState();
}

class _HealhConditionsInputState extends State<HealhConditionsInput> {
  final List<String> _selectedConditions = []; // State variable to hold the selected conditions

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Health Conditions',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            children: _buildConditionChips(),
          ),
          const SizedBox(height: 15),
          const TextField(
            decoration: InputDecoration(
              labelText: 'If Others, please specify',
              labelStyle: TextStyle(
                fontSize: 16,
              ),
              border: UnderlineInputBorder(),
            ),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildConditionChips() {
    final conditions = [
      'Diabetes',
      'High blood pressure',
      'Heart disease',
      'Food allergies',
      'Digestive disorders',
      'Thyroid disorders',
      'Others',
    ];

    return conditions.map((condition) {
      final isSelected = _selectedConditions.contains(condition);

      return ChoiceChip(
        label: Text(condition,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 16,
          ),
        ),
        selected: isSelected,
        selectedColor: SystemColors.primaryColor,
        disabledColor: Colors.grey[300],
        backgroundColor: SystemColors.secondaryColor2,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _selectedConditions.add(condition);
            } else {
              _selectedConditions.remove(condition);
            }
          });
        },
      );
    }).toList();
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            // Add code to submit the form
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: SystemColors.primaryColorDarker,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21),
            ),
          ),
          child: const Text('Submit',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: SystemColors.bgWhite,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const PreferencesPersonal());
}