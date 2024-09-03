import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'home_page.dart';

class RegDone extends StatelessWidget {
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

      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30),
              Header(),
              SizedBox(height: 16.0),
              IntroText(),
              SizedBox(height: 40.0),
              PhotoContent(),
              SizedBox(height: 20.0),
              GoButton(),
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
          'All Done',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const Image(
          image: AssetImage('assets/check_small.png'),
          height: 30.0,
          width: 30.0,
        )
      ],
    );
  }
}

class IntroText extends StatelessWidget {
  const IntroText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Thanks for giving us your time! Now you are ready for healthier pregnancy.',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: SystemColors.textColorDarker.withOpacity(0.7),
          ),
    );
  }
}

class PhotoContent extends StatelessWidget {
  const PhotoContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Image(
          image: AssetImage('assets/ok.png'),
          height: 300.0,
          width: 300.0,
        )
    );
  }
}

class GoButton extends StatefulWidget {
  const GoButton({Key? key}) : super(key: key);

  @override
  _GoButtonState createState() => _GoButtonState();
}

class _GoButtonState extends State<GoButton> {
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
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
            'Let\'s Go!',
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
    home: RegDone(),
  ));
}