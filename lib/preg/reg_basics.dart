import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:gab_ai/login.dart';

class RegisBasics extends StatelessWidget {
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
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
              Text('Email Address / Phone Number',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  labelText: 'Your Email / Phone Number',
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
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement registration logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: SystemColors.primaryColorDarker,
                  minimumSize: const Size(230, 58),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21.0),
                  ),
                ),
                child: Text('Next',
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