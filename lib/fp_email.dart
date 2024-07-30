import 'package:flutter/material.dart';
import 'colors.dart';
import 'theme.dart';
import 'login.dart';
import 'fp_emailsent.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  void _sendEmail() async {
  setState(() {
    _isLoading = true;
  });

  // Simulate a network request or any async operation
  await Future.delayed(Duration(seconds: 2));

  setState(() {
    _isLoading = false;
  });

  // Navigate to the FPSent screen
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => FPSent(email: _emailController.text),
    ),
  );
}

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
    
		body: Stack(
		  children: [
		    LayoutBuilder(
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
                Text('Forgot Password!',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 20.0),
                Text('Don\'t worry! Enter your registered email or phone number below to receive password reset instructions.',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 70.0),
                TextField(
                  controller: _emailController,
                  style: const TextStyle(
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontFamily: 'Merriweather',
                      color: SystemColors.textColor,
                    ),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: SystemColors.textColorDarker,
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Remember Password? "),
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
                const SizedBox(height: 70.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: ElevatedButton(
                    onPressed: _sendEmail,
                    style: ElevatedButton.styleFrom(
                    backgroundColor: SystemColors.primaryColorDarker,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21.0),
                      ),
                    ),
                    child: const Text(
                    'Send',
                    style: TextStyle(
                      color: SystemColors.accentColor2,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don\'t have an account? "),
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
                        child: Text('Sign Up'),
                      ),
                    ),
                  ],
                ),
              ],
              ),
            ),
            ),
          ),
          );
        },
        ),
        if (_isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
		  ],
		),
	  ),
	);
  }
}