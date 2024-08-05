import 'package:flutter/material.dart';
import 'package:gab_ai/theme.dart';
import 'theme.dart';
import 'colors.dart';
import 'login.dart';
import 'preg/reg_basics.dart';

void main() {
  runApp(RegisterAs());
}

class RegisterAs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Button Demo',
      theme: appTheme,
      home: Scaffold(
        backgroundColor: SystemColors.bgColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
            padding: EdgeInsets.all(constraints.maxWidth * 0.05), // 5% of the screen width
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: constraints.maxHeight * 0.1), // 10% of the screen height
                Text('Register As ...',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Container(
                        height: 150,
                        width: 150,
                        padding: const EdgeInsets.all(4.0), // 2% of the screen width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: SystemColors.primaryColorDarker,
                          boxShadow: [
                            BoxShadow(
                              color: SystemColors.textColor.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ]
                        ),
                        child: Image.asset('assets/preg_icon.png'),
                      ),
                      iconSize: constraints.maxWidth * 0.1, // 10% of the screen width
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisBasics(),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: constraints.maxWidth * 0.02), // 2% of the screen width
                    Flexible(
                      child: Text(
                        'Pregnant Woman',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'Nutritionist/Dietitian',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: constraints.maxWidth * 0.02), // 2% of the screen width
                    IconButton(
                      icon: Container(
                        height: 150,
                        width: 150,
                        padding: const EdgeInsets.all(4.0), // 2% of the screen width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: SystemColors.primaryColorDarker,
                          boxShadow: [
                            BoxShadow(
                              color: SystemColors.textColor.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ]
                        ),
                        child: Image.asset('assets/nd_icon.png'),
                      ),
                      iconSize: constraints.maxWidth * 0.1, // 10% of the screen width
                      onPressed: () {
                        // Add your button's onPressed logic here
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have an account? "),
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
        )
        );
        },
      ),
      ),
    );
  }
}