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
  final _moodController = TextEditingController();
  final _bodyController = TextEditingController();
  String? _selectedMood;

  void _saveJournal() {
    final title = _titleController.text;
    final mood = _moodController.text;
    final body = _bodyController.text;

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
        backgroundColor: SystemColors.bgColorLighter,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                  border: const UnderlineInputBorder(),
                  focusedBorder: const UnderlineInputBorder(),
                  labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),// Padding for input text
                ),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                children: ['Happy', 'Sad', 'Excited', 'Angry', 'Relaxed']
                  .map((mood) => ChoiceChip(
                    label: Text(mood),
                    selected: _selectedMood == mood,
                    onSelected: (selected) {
                      setState(() {
                        _selectedMood = selected ? mood : null;
                      });
                    },
                    selectedColor: SystemColors.primaryColorDarker,
                    backgroundColor: SystemColors.secondaryColor2,
                    labelStyle: TextStyle(
                      color: _selectedMood == mood ? SystemColors.bgWhite : SystemColors.textColorDarker,
                    ),
                  ))
                .toList(),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _bodyController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Write something here...',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.grey[500],
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                maxLines: 10,
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: _saveJournal,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50), // Set the button size
                  backgroundColor: SystemColors.primaryColorDarker,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  )
                ),
                child: Text('Save',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: SystemColors.bgWhite,
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