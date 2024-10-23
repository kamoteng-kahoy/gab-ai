import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gab_ai/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Personal Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EditPersonalInfo(),
    );
  }
}

class EditPersonalInfo extends StatelessWidget {
  const EditPersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent, // Removes shadow when scrolling
        scrolledUnderElevation: 0, // Prevents shadow when scrolling
        backgroundColor: SystemColors.bgColorLighter,
        title: Text('Edit Personal Info',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(FluentIcons.arrow_left_20_filled),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PersonalInfo(),
              SizedBox(height: 40),
              OtherInfo(),
              SizedBox(height: 150),
              SaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  String _selectedWeightUnit = 'kg';
  String _selectedTrimester = 'Select Trimester';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Personal Information',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                constraints: const BoxConstraints(minWidth: 20), // Set the desired minimum width
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Age',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                    ),
                    border: const UnderlineInputBorder(),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: SystemColors.primaryColorDarker,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              flex: 2,
              child: Container(
                constraints: const BoxConstraints(minWidth: 20), // Set the desired minimum width
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Weight',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                    ),
                    border: const UnderlineInputBorder(),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: SystemColors.primaryColorDarker,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'in',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black54,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedWeightUnit,
                  isExpanded: true,
                  items: <String>['kg', 'lbs'].map((String value) {
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
                      _selectedWeightUnit = newValue!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                constraints: const BoxConstraints(minWidth: 20), // Set the desired minimum width
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Height in cm',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                    ),
                    border: const UnderlineInputBorder(),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: SystemColors.primaryColorDarker,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            const SizedBox(width: 12),
          Container(
              width: 250,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black54,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedTrimester,
                  isExpanded: true,
                  items: <String>['Select Trimester','1st trimester (weeks 1-12)', '2nd trimester (weeks 13-28)', '3rd trimester (weeks 29-40)'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
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
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class OtherInfo extends StatelessWidget {
  const OtherInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Edit Address',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter address here',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 16,
            ),
            border: const UnderlineInputBorder(),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: SystemColors.primaryColorDarker,
              ),
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          'Edit Phone Number',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: TextField(
            style: Theme.of(context).textTheme.bodyMedium,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            decoration: InputDecoration(
              prefixIcon: SizedBox(
                width: 120,
                child: CountryCodePicker(
                  onChanged: print,
                  initialSelection: 'PH',
                  favorite: const ['+63', 'PH'],
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                  textStyle: TextStyle(
                    fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
                    color: SystemColors.textColorDarker,
                    fontSize: 16,
                  ),
                ),
              ),
              hintText: 'Enter your phone number',
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: SystemColors.textColorDarker.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SaveButton extends StatefulWidget {
  const SaveButton({super.key});

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool _isLoading = false;

  void _handleSave() {
    setState(() {
      _isLoading = true;
    });

    // Simulate a network request or any async operation
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pop();

      // Show a snackbar or any other feedback to the user
      const snackBar = SnackBar(
      content: AwesomeSnackbarContent(
        title: 'Success',
        message: 'Information saved successfully!',
        contentType: ContentType.success,
      ),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        child: ElevatedButton(
          onPressed: _isLoading ? null : _handleSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: SystemColors.primaryColorDarker,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: _isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
              )
              : Text(
                  'Save',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
        ),
      ),
    );
  }
}