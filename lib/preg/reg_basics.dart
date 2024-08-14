import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/login.dart';
import 'reg_otp.dart';
import 'package:country_code_picker/country_code_picker.dart';

class RegisBasics extends StatefulWidget {
  @override
  State<RegisBasics> createState() => _RegisBasicsState();
}

class _RegisBasicsState extends State<RegisBasics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
              HeaderRow(),
              SizedBox(height: 16.0),
              IntroText(),
              SizedBox(height: 40.0),
              FullNameTextField(),
              SizedBox(height: 20.0),
              EmailTextField(),
              SizedBox(height: 20.0),
              PhoneNumberField(),
              SizedBox(height: 20.0),
              PasswordTextField(),
              SizedBox(height: 40.0),
              NextButton(),
              SizedBox(height: 30.0),
              BackToLogin(),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'The Basics',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          '1/3',
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
      'Let\'s start with the basics. Enter your name and login credentials.',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: SystemColors.textColorDarker.withOpacity(0.7),
          ),
    );
  }
}

class FullNameTextField extends StatelessWidget {
  const FullNameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        labelText: 'Your Full Name',
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: SystemColors.textColorDarker.withOpacity(0.7),
            ),
        prefixIcon: const Icon(
          Icons.person_outlined,
          color: SystemColors.textColorDarker,
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        labelText: 'Your Email',
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: SystemColors.textColorDarker.withOpacity(0.7),
            ),
        prefixIcon: const Icon(
          Icons.email_outlined,
          color: SystemColors.textColorDarker,
        ),
      ),
    );
  }
}

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 120,
          child: CountryCodePicker(
            onChanged: print,
            initialSelection: 'PH',
            favorite: ['+63', 'PH'],
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
          ),
        ),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              labelText: 'Your Phone Number',
              labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: SystemColors.textColorDarker.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({Key? key}) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyMedium,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: 'Your Password',
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: SystemColors.textColorDarker.withOpacity(0.7),
            ),
        prefixIcon: const Icon(
          Icons.lock_outlined,
          color: SystemColors.textColorDarker,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _togglePasswordVisibility,
        ),
      ),
    );
  }
}

class NextButton extends StatefulWidget {
  const NextButton({Key? key}) : super(key: key);

  @override
  _NextButtonState createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
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
        builder: (context) => RegOTP(),
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
            'Next',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
          ),
    );
  }
}

class BackToLogin extends StatelessWidget {
  const BackToLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(
            color: SystemColors.textColorDarker.withOpacity(0.7),
            fontSize: 16.0,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.zero,
            child: Text('Log In'),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegisBasics(),
  ));
}