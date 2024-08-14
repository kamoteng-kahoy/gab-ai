import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegPhoto extends StatelessWidget {
  const RegPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColor,
      appBar: AppBar(
		  backgroundColor: SystemColors.bgColor,
		  title: Image.asset(
			'assets/logo-word.png',
			height: 40.0,
			fit: BoxFit.contain,
		  ),
		  centerTitle: true,
		  ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              const Header(),
              const SizedBox(height: 16.0),
              const IntroText(),
              const SizedBox(height: 40.0),
              UploadPhoto(),
              const SizedBox(height: 60.0),
              UploadButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Upload Photo',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          '3/3',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
      ],
    );
  }
}

class IntroText extends StatelessWidget {
  const IntroText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Add a profile photo to recognize yourself!',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: SystemColors.textColorDarker.withOpacity(0.7),
      ),
    );
  }
}

class UploadPhoto extends StatefulWidget {
  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: const Color(0xFFD9D9D9),
            backgroundImage: _image != null ? FileImage(_image!) : null,
            child: _image == null
                ? const Icon(
                    Icons.camera_alt,
                    color: SystemColors.textColorDarker,
                    size: 50.0,
                  )
                : null,
          ),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );*/
          },
          child: const Padding(
            padding: EdgeInsets.zero,
            child: Text(
              'Skip',
              style: TextStyle(
                fontSize: 16.0,
                )
              ),
          ),
        ),
      ],
    );
  }
}

class UploadButton extends StatefulWidget {
  const UploadButton({Key? key}) : super(key: key);

  @override
  _UploadButtonState createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  bool _isLoading = false;

  void _handleNextButtonPress() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a network request or any async operation
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
    // Handle the next button press logic here
    // For example, navigate to the next screen
    /*Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegOTP(),
      ),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handleNextButtonPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: SystemColors.primaryColorDarker,
        minimumSize: const Size(230, 58),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21.0),
        ),
      ),
      child: _isLoading
        ? const SizedBox(
            height: 24.0,
            width: 24.0,
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 2.0,
            ),
        )
        : Text(
            'Upload',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontSize: 20.0,
            ),
        ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegPhoto(),
  ));
}