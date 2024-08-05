import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class RegOTP extends StatefulWidget {
  @override
  State<RegOTP> createState() => _RegOTPState();
}

class _RegOTPState extends State<RegOTP> {
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

    /*Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegOTP(),
      ),
    );*/
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
                  Text('Confirm Email/Phone',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('2/3',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w900,)
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text('We have just send an OTP number to the given email/phone number. Please enter those below.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: SystemColors.textColorDarker.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 30),
              Image.asset(
                'assets/otp.png',
                height: 200.0,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              CustomPinCodeTextField(
                context: context,
                onChanged: (value) {
                  // Handle OTP input change
                },
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
            ],
          ),
        ),
      ),
    );
  }
}

class CustomPinCodeTextField extends StatelessWidget {
  final BuildContext context;
  final Function(String) onChanged;

  const CustomPinCodeTextField({
    Key? key,
    required this.context,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: this.context,
      length: 6,
      onChanged: onChanged,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        activeColor: SystemColors.primaryColor,
        inactiveColor: SystemColors.primaryColor,
        selectedColor: SystemColors.primaryColor,
        selectedFillColor: Colors.white,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegOTP(),
  ));
}