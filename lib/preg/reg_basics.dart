import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/login.dart';
import 'reg_otp.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegisBasics extends StatefulWidget {
  @override
  State<RegisBasics> createState() => _RegisBasicsState();
}

class _RegisBasicsState extends State<RegisBasics> {
  bool _isLoading = false;

  void _handleNextButtonPress() async {
    setState(() {
      _isLoading = true;
    });

  // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegOTP(),
      ),
    );
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('The Basics',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text('1/3',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w900,)
                  ),
                ],
              ),

              const SizedBox(height: 16.0),

              Text('Let\'s start with the basics. Enter your name and login credentials.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: SystemColors.textColorDarker.withOpacity(0.7),
                ),
              ),

              const SizedBox(height: 40.0),

              Text('Full Name',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
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
              ),

              const SizedBox(height: 16.0),

              Text('Email Address',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
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
              ),
              const SizedBox(height: 16.0),

              Text('Phone Number',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8.0),

              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  print(number.phoneNumber);
                },
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: Theme.of(context).textTheme.bodyMedium,
                initialValue: PhoneNumber(isoCode: 'PH'),
                textFieldController: TextEditingController(),
                formatInput: true,
                keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                inputDecoration: InputDecoration(
                  labelText: 'Your Phone Number',
                  labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: SystemColors.textColorDarker.withOpacity(0.7),
                  ),
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: SystemColors.textColorDarker,
                  ),
                ),
                selectorButtonOnErrorPadding: 0,
              ),

              const SizedBox(height: 16.0),

              Text('Password',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                style: Theme.of(context).textTheme.bodyMedium,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Your Password',
                  labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: SystemColors.textColorDarker.withOpacity(0.7),
                  ),
                  prefixIcon: const Icon(
                      Icons.lock_outlined,
                      color: SystemColors.textColorDarker,
                    ),
                  suffixIcon: const Icon(Icons.visibility),
                ),
              ),

              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleNextButtonPress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: SystemColors.primaryColorDarker,
                  minimumSize: const Size(230, 58),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21.0),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ) : Text('Next',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
              ),

              const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: SystemColors.textColorDarker,
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
                ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegisBasics(),
  ));
}