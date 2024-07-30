import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'colors.dart';
import 'theme.dart';
import 'login.dart';

class FPSent extends StatelessWidget {
  final String email;

  const FPSent({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
	return MaterialApp(
	  theme: appTheme,
	  home: Scaffold(
		backgroundColor: SystemColors.secondaryColor,
		appBar: AppBar(
		  backgroundColor: SystemColors.secondaryColor,
		  title: Image.asset(
			'assets/logo-word.png',
			height: 40.0,
			fit: BoxFit.contain,
		  ),
		  centerTitle: true,
		  automaticallyImplyLeading: false,
		),
    
		body: LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: IntrinsicHeight(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60.0),
              Text('Email Sent!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              const SizedBox(height: 20.0),

              Text('We\'ve sent a password resent link to $email.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 50.0),
              Image.asset(
                'assets/email_sent.png',
                width: constraints.maxWidth * 0.5,
                height: constraints.maxHeight * 0.2,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn\'t Recieve? ",
                  style: TextStyle(
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0)
                  ),
                  TextButton(
                    onPressed: () {
                      
                    },
                    child: const Padding(
                      padding: EdgeInsets.zero,
                      child: Text(
                        'Resend',
                        style: TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                        ),),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.08,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: SystemColors.primaryColorDarker,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21.0),
                    ),
                  ),
                  child: const Text('Back to Login',
                  style: TextStyle(
                    color: SystemColors.accentColor2,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  
                },
                child: const Padding(
                  padding: EdgeInsets.zero,
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      fontFamily: 'Merriweather',
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: SystemColors.textColor
                    ),),
                ),
              ),
            ],
            ),
          ),
          ),
        ),
        );
      },
      ),
	  ),
	);
  }
}