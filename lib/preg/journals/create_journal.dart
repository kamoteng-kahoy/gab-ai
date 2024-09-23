import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/preg/appointments/picture_preview.dart';

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
  final TextEditingController _bodyController = TextEditingController();
  List<File> _selectedFiles = [];
  String? _selectedMood;
  String? _selectedCategory;
  List<FoodIntakeDetails> _foodIntakeDetails = [];

  void _saveJournal() {
    final body = _bodyController.text;
    final selectedMood = _selectedMood;
    final selectedCategory = _selectedCategory;
    final createdTime = DateTime.now();

    // Here you can add the logic to save the journal entry
    print('Category: $selectedCategory');
    print('Mood: $selectedMood');
    print('Body: $body');
    for (var file in _selectedFiles) {
      print('Files Selected: $file.path');
    }
    print('Created Time: $createdTime');

    for (var food in _foodIntakeDetails) {
      print('Food Name: ${food.foodName}');
      print('Servings: ${food.servings}');
      print('Portion: ${food.portion}');
    }

    const snackBar = SnackBar(
      content: AwesomeSnackbarContent(
        title: 'Success',
        message: 'Journal has been saved!',
        contentType: ContentType.success,
      ),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.pop(context, {
      'category': selectedCategory,
      'body': body,
      'mood': selectedMood,
      'createdTime': createdTime,
    });
  }

  void _onFilesSelected(List<File> files) {
    setState(() {
      _selectedFiles = files;
    });
  }

  void _onFoodIntakeChanged(List<FoodIntakeDetails> details) {
    setState(() {
      _foodIntakeDetails = details;
    });
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
              MealCategory(
                onCategorySelected: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
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
              FoodIntake(onFoodIntakeChanged: _onFoodIntakeChanged),
              const SizedBox(height: 30),
              JournalBody(
                controller: _bodyController,
                onFilesSelected: _onFilesSelected),
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
  final Function(String) onCategorySelected;
  const MealCategory({super.key, required this.onCategorySelected});

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
                    fontSize: 18,
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
                    fontSize: 18
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
              widget.onCategorySelected(newValue!);
            },
            dropdownColor: SystemColors.accentColor2, // Set the dropdown background color
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

  const MoodChoiceChip({super.key, required this.selectedMood, required this.onMoodSelected});

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

class FoodIntakeDetails {
  final String foodName;
  final int servings;
  final String portion;

  FoodIntakeDetails({required this.foodName, required this.servings, required this.portion});
}

class FoodIntake extends StatefulWidget {
  final Function(List<FoodIntakeDetails>) onFoodIntakeChanged;

  const FoodIntake({super.key, required this.onFoodIntakeChanged});

  @override
  _FoodIntakeState createState() => _FoodIntakeState();
}

class _FoodIntakeState extends State<FoodIntake> {
  final List<Widget> _foodItems = [];
  final List<String?> _selectedPortions = ['oz'];
  final List<TextEditingController> _controllers = [];
  final List<TextEditingController> _numServingsControllers = [];

  List<FoodIntakeDetails> getFoodIntakeDetails() {
    List<FoodIntakeDetails> details = [];
    for (int i = 0; i < _controllers.length; i++) {
      details.add(FoodIntakeDetails(
        foodName: _controllers[i].text,
        servings: int.tryParse(_numServingsControllers[i].text) ?? 0,
        portion: _selectedPortions[i]!,
      ));
    }
    return details;
  }

  void _notifyParent() {
    widget.onFoodIntakeChanged(getFoodIntakeDetails());
  }

  Widget _buildFoodItem(int index) {
    if (_controllers.length <= index) {
      _controllers.add(TextEditingController());
      _numServingsControllers.add(TextEditingController());
    }

    final TextEditingController controller = _controllers[index];
    final TextEditingController numServingsController = _numServingsControllers[index];

    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
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
                onChanged: (value) => _notifyParent(),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 40,
              child: TextField(
                controller: numServingsController,
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
                onChanged: (value) => _notifyParent(),
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
                      _notifyParent();
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
                  _controllers.removeAt(index);
                  _numServingsControllers.removeAt(index);
                  _notifyParent();
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
              _notifyParent();
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

class JournalBody extends StatefulWidget {
  final TextEditingController controller;
  final Function(List<File>) onFilesSelected;

  const JournalBody({super.key, required this.controller, required this.onFilesSelected});

  @override
  State<JournalBody> createState() => _JournalBodyState();
}

class _JournalBodyState extends State<JournalBody> {
  
  List<File> _selectedFiles = [];

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _selectedFiles.addAll(result.paths.map((path) => File(path!)).toList());
      });
      widget.onFilesSelected(_selectedFiles);
    }
  }

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
          SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: widget.controller,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'Write other details here ...',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black.withOpacity(0.4),
                          fontSize: 16,
                        ),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: SystemColors.primaryColorDarker),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: SystemColors.textColorDarker,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickFiles,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40), // Set the button size
                    backgroundColor: SystemColors.accentColor2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                  ),
                  child: Text('Attach File',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: SystemColors.textColorDarker,
                    ),
                  ),
                ),
                if (_selectedFiles.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Column(
                    children: _selectedFiles.map((file) {
                      return Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImagePreviewScreen(imagePath: file.path),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Text(
                                  'Selected File: ${file.path.split(Platform.pathSeparator).last}',
                                  style: const TextStyle(
                                    color: SystemColors.textColorDarker,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(FluentIcons.dismiss_24_filled),
                            onPressed: () {
                              setState(() {
                                _selectedFiles.remove(file);
                              });
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ],
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

