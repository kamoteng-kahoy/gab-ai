import 'package:flutter/material.dart';
import 'colors.dart';
import 'theme.dart';
import 'login.dart';
import 'fp_emailsent.dart';
import 'package:gab_ai/reg_as.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isEmpty = false;
  String _email = '';
  String _errorMessage = '';

  bool _isValidEmail(String email){
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  @override
  void initState(){
    super.initState();
    _emailController.addListener(_validateEmail);
  }

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  void _validateEmail(){
    setState(() {
      final email = _emailController.text;
      if (email.isEmpty){
        _errorMessage = 'Please enter your email.';
      } else if (!_isValidEmail(email)){
        _errorMessage = 'Please enter a valid email address.';
      } else {
        _errorMessage = '';
      }
    });
  }

  void _submit(){
    setState(() {
      _validateEmail();
      if (_errorMessage.isEmpty){
        _isLoading = true;
        
        // Navigate to the FPSent screen
         if (_errorMessage.isEmpty) {
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              _isLoading = false;
            });
            // add submit logic here
            // Navigate to the FPSent screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FPSent(email: _emailController.text),
              ),
            );
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
	return MaterialApp(
	  theme: appTheme,
	  home: Scaffold(
		backgroundColor: SystemColors.bgColor,
		appBar: AppBar(
		  backgroundColor: SystemColors.bgColor,
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
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(
                      fontFamily: 'Merriweather',
                      color: SystemColors.textColor,
                    ),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: SystemColors.textColorDarker,
                    ),
                    errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
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
                    onPressed: _isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                    backgroundColor: SystemColors.primaryColorDarker,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21.0),
                      ),
                    ),
                    child: _isLoading
                    ? const SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(SystemColors.accentColor2),
                        strokeWidth: 2.0,
                      ),
                    )
                    : const Text(
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
                            builder: (context) => RegisterAs(),
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
		  ],
		),
	  ),
	);
  }
}