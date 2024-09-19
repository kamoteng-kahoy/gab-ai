import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NewJournal(),
    );
  }
}

class NewJournal extends StatefulWidget {
  const NewJournal({super.key});

  @override
  _NewJournalState createState() => _NewJournalState();
}

class _NewJournalState extends State<NewJournal> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  String? _selectedMood;

  void _saveJournal() {
    final title = _titleController.text;
    final body = _bodyController.text;
    String? _selectedMood;

    // Here you can add the logic to save the journal entry
    print('Title: $title');
    print('Mood: $_selectedMood');
    print('Body: $body');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      appBar: AppBar(
        title: Text('New Journal',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        toolbarHeight: 70,
        leading: IconButton(
          icon: const Icon(FluentIcons.arrow_left_20_filled),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: SystemColors.bgColorLighter,
        centerTitle: true,
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Meal Category',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),           
                ),
              ),
              const SizedBox(height: 10),
              const MealCategory(),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Mood for the day',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),           
                ),
              ),
              const SizedBox(height: 10),
              MoodChoiceChip(
                selectedMood: _selectedMood,
                onMoodSelected: (mood) {
                  setState(() {
                    _selectedMood = mood;
                  });
                },
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Food Intake',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),           
                ),
              ),
              const SizedBox(height: 10),
              FoodIntake(),
              const SizedBox(height: 30),
              JournalBody(),
              const SizedBox(height: 60),
              SaveButton(onPressed: _saveJournal),
            ],
          ),
        ),
      ),
    );
  }
}

class MealCategory extends StatefulWidget {
  const MealCategory({super.key});

  @override
  _MealCategoryState createState() => _MealCategoryState();
}

class _MealCategoryState extends State<MealCategory> {
  String? _selectedCategory;
  final List<String> _categories = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: SystemColors.accentColor2, // Set the background color
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: SizedBox(
          width: double.infinity,
          height: 40.0,
          child: DropdownButton<String>(
            value: _selectedCategory,
            hint: Text('Select a category',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            items: _categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: SystemColors.textColorDarker,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
            },
            dropdownColor: Colors.white, // Set the dropdown background color
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: SystemColors.textColorDarker,
            ),
          ),
        ),
      ),
    );
  }
}

class MoodChoiceChip extends StatefulWidget {
  final String? selectedMood;
  final Function(String?) onMoodSelected;

  MoodChoiceChip({required this.selectedMood, required this.onMoodSelected});

  @override
  _MoodChoiceChipState createState() => _MoodChoiceChipState();
}

class _MoodChoiceChipState extends State<MoodChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: ['Happy', 'Sad', 'Excited', 'Angry', 'Relaxed']
          .map((mood) => ChoiceChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/icons/$mood.png', width: 25, height: 25),
                    const SizedBox(width: 10),
                    Text(mood),
                  ],
                ),
                selected: widget.selectedMood == mood,
                onSelected: (selected) {
                  widget.onMoodSelected(selected ? mood : null);
                },
                selectedColor: SystemColors.primaryColorDarker,
                backgroundColor: SystemColors.accentColor2,
                labelStyle: TextStyle(
                  color: widget.selectedMood == mood
                      ? SystemColors.bgWhite
                      : SystemColors.textColorDarker,
                ),
              ))
          .toList(),
    );
  }
}

class FoodIntake extends StatefulWidget {
  @override
  _FoodIntakeState createState() => _FoodIntakeState();
}

class _FoodIntakeState extends State<FoodIntake> {
  List<Widget> _foodItems = [];
  List<String?> _selectedPortions = ['oz'];

  Widget _buildFoodItem(int index) {
    final TextEditingController _controller = TextEditingController();
    final TextEditingController _numServingsController = TextEditingController();

    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: 1,
                scrollPadding: const EdgeInsets.all(20),
                decoration: InputDecoration(
                  hintText: 'Food Item',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 16
                  ),
                  border: const  UnderlineInputBorder(),
                  focusedBorder: const  UnderlineInputBorder(
                    borderSide: BorderSide(color: SystemColors.primaryColorDarker),
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: SystemColors.textColorDarker,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 40,
              child: TextField(
                controller: _numServingsController,
                maxLines: 1,
                scrollPadding: const EdgeInsets.all(20),
                decoration: InputDecoration(
                  hintText: '# of Servings',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 16
                  ),
                  border: const  UnderlineInputBorder(),
                  focusedBorder: const  UnderlineInputBorder(
                    borderSide: BorderSide(color: SystemColors.primaryColorDarker),
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: SystemColors.textColorDarker,
                  fontSize: 16,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 10), 
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: SystemColors.accentColor2,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  value: _selectedPortions[index],
                  onChanged: (newValue) {
                    setState(() {
                      _selectedPortions[index] = newValue!;
                    });
                  },
                  dropdownColor: Colors.white,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: SystemColors.textColorDarker,
                  ),
                  items: <String>['oz', 'cup', 'tablespoon', 'teaspoon', 'slice', 'piece', 'small', 'medium', 'large']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  isExpanded: true, // Ensures the dropdown takes the full width of the container
                  underline: const SizedBox(), // Removes the default underline
                ),
              ),
            ),
            IconButton(
              icon: const Icon(FluentIcons.dismiss_24_filled),
              iconSize: 20,
              onPressed: () {
                setState(() {
                  _foodItems.removeAt(index);
                  _selectedPortions.removeAt(index);
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_foodItems.isEmpty) {
      _foodItems.add(_buildFoodItem(0));
      _selectedPortions.add('oz');
    }

    return Column(
      children: [
        ..._foodItems.asMap().entries.map((entry) {
          int index = entry.key;
          return _buildFoodItem(index);
        }).toList(),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            setState(() {
              _foodItems.add(_buildFoodItem(_foodItems.length));
              _selectedPortions.add('oz');
            });
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Set the button padding
            backgroundColor: Colors.transparent, // Make the background transparent
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text('Add Food Item',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: SystemColors.primaryColorDarker,
            ),
          ),
        ),
      ],
    );
  }
}

class JournalBody extends StatelessWidget {
  final TextEditingController _bodyController = TextEditingController();

  JournalBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Other Details',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            TextField(
              controller: _bodyController,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Write your journal entry here...',
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black.withOpacity(0.4),
                      fontSize: 16,
                    ),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(FluentIcons.attach_24_filled),
                onPressed: () {
                  // Define your function here
                  print('Icon pressed!');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 50), // Set the button size
        backgroundColor: SystemColors.primaryColorDarker,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21),
        ),
      ),
      child: Text(
        'Save',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: SystemColors.bgWhite,
        ),
      ),
    );
  }
}

