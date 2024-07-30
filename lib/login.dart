import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'colors.dart';
import 'theme.dart';
import 'fp_email.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      title: 'GAB-AY: Login',
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isEmpty = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.secondaryColor,
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
                      Image.asset(
                        'assets/logo-word.png',
                        width: constraints.maxWidth * 0.5,
                        height: constraints.maxHeight * 0.2,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 50.0),
                      TextField(
                        controller: _emailController,
                        style: const TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Username or Email',
                          labelStyle: TextStyle(
                            color: SystemColors.textColor,
                            fontFamily: 'Merriweather'
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _passwordController,
                        style: const TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontFamily: 'Merriweather',
                            color: SystemColors.textColor,
                          ),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 6.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  // Simulate a delay for loading
                                  await Future.delayed(const Duration(seconds: 2));

                                  setState(() {
                                    _isLoading = false;
                                  });

                                  // Navigate to Forgot Password screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgotPassPage(),
                                    ),
                                  );
                                },
                          child: _isLoading
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      SystemColors.textColor,
                                    ),
                                    strokeWidth: 3.0,
                                ),
                              )
                              : const Text('Forgot Password?'),
                        ),
                      ),
                      if(_isEmpty == true)
                        const Text(
                          'Please fill in all fields.',
                          style: TextStyle(
                            color: SystemColors.errorColor,
                          ),
                        ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty){
                              _isEmpty = true;
                            }
                            else{
                              Text email = Text(_emailController.text);
                            Text password = Text(_passwordController.text);
                            print('Email: $email');
                            print('Password: $password');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SystemColors.primaryColorDarker,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21.0),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: SystemColors.accentColor2,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 6.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          TextButton(
                            onPressed: () {
                              // Add your sign-up logic here
                            },
                            child: const Padding(
                              padding: EdgeInsets.zero,
                              child: Text('Sign Up'),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 30.0),
                    const Text('Or continue with:'),
                    const SizedBox(height: 10.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              // Add your Facebook sign-in logic here
                            },
                            icon: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: const Image(
                                image: AssetImage('assets/facebook.png'),
                                width: 50.0,
                                height: 50.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          IconButton(
                            onPressed: () {
                              // Add your Google sign-in logic here
                            },
                            icon: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: const Image(
                                image: AssetImage('assets/google.png'),
                                width: 50.0,
                                height: 50.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

