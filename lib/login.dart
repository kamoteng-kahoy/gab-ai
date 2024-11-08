import 'package:flutter/material.dart';
import 'package:gab_ai/preg/main_screen.dart';
import 'package:gab_ai/services_supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart';
import 'theme.dart';
import 'fp_email.dart';
import 'reg_as.dart';

void main() {
  runApp(const LoginScreen());
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
  bool _isLoadingForgotPass = false;
  bool _isLoadingLogin = false;
  String _errorMessage = '';

  void _submit() async {
  final email = _emailController.text;
  final password = _passwordController.text;

  if (email.isEmpty || password.isEmpty) {
    setState(() {
      _errorMessage = 'Please fill in all fields.';
    });
    return;
  }

  setState(() {
    _errorMessage = '';
    _isLoadingLogin = true;
  });

  try {
    // 1. First authenticate with Supabase Auth
    final response = await SupabaseService().client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      setState(() {
        _errorMessage = 'Invalid email or password';
      });
      return;
    }

    // 2. After successful auth, get the user's UUID
    final userId = response.user!.id;
    print('Auth successful. User ID: $userId'); // Debug print

    // 3. Query the users table using the UUID with correct syntax
    final userResponse = await SupabaseService().client
        .from('users')
        .select('role, is_pregnant, is_verified_nd, first_name, last_name')
        .eq('user_id', userId)
        .maybeSingle();

    print('User data response: $userResponse'); // Debug print

    // Check if we got any data back
    if (userResponse == null) {
      setState(() {
        _errorMessage = 'User profile not found. Please complete registration.';
      });
      return;
    }

    // Store user session
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userId', userId);
    await prefs.setString('userRole', userResponse['role'] as String);
    await prefs.setString('firstName', userResponse['first_name'] as String);
    await prefs.setString('lastName', userResponse['last_name'] as String);

    // Handle different user roles
    final role = userResponse['role'] as String;
    final isPregnant = userResponse['is_pregnant'] as bool;
    final isVerifiedNd = userResponse['is_verified_nd'] as bool;

    if (!mounted) return;

    switch (role) {
      case 'PregnantWoman':
        if (isPregnant) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false,
          );
        } else {
          setState(() {
            _errorMessage = 'Account not marked as pregnant. Please update your profile.';
          });
        }
        break;

      case 'Nutritionist':
        if (isVerifiedNd) {
          //
        } else {
          setState(() {
            _errorMessage = 'Your nutritionist account is pending verification.';
          });
        }
        break;

      case 'GeneralUser':
        //
        break;

      default:
        setState(() {
          _errorMessage = 'Invalid user role.';
        });
    }

  } catch (e) {
    print('Error during login: $e'); // Debug print
    
    if (e.toString().contains('JSON object requested, multiple (or no) rows returned')) {
      setState(() {
        _errorMessage = 'User profile not found. Please complete registration.';
      });
    } else {
      setState(() {
        _errorMessage = 'An error occurred while logging in. Please try again.';
      });
    }
  } finally {
    setState(() {
      _isLoadingLogin = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColor,
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
                      LogoImage(constraints: constraints),
                      const SizedBox(height: 50.0),
                      EmailTextField(controller: _emailController),
                      const SizedBox(height: 16.0),
                      PasswordTextField(controller: _passwordController),
                      const SizedBox(height: 6.0),
                      ForgotPasswordButton(
                        isLoading: _isLoadingForgotPass,
                        onPressed: () async {
                          setState(() {
                            _isLoadingForgotPass = true;
                          });

                          // Simulate a delay for loading
                          await Future.delayed(const Duration(seconds: 2));

                          setState(() {
                            _isLoadingForgotPass = false;
                          });

                          // Navigate to Forgot Password screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassPage(),
                            ),
                          );
                        },
                      ),
                      if (_errorMessage.isNotEmpty)
                        ErrorMessage(message: _errorMessage),
                      const SizedBox(height: 16.0),
                      LoginButton(
                        isLoading: _isLoadingLogin,
                        onPressed: _submit,
                      ),
                      const SizedBox(height: 6.0),
                      const SignUpRow(),
                      const SizedBox(height: 30.0),
                      Text(
                        'Or continue with:',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10.0),
                      const SocialMediaButtons(),
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

class LogoImage extends StatelessWidget {
  final BoxConstraints constraints;

  const LogoImage({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo-word.png',
      width: constraints.maxWidth * 0.6,
      height: constraints.maxHeight * 0.2,
      fit: BoxFit.contain,
    );
  }
}

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;

  const EmailTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        fontFamily: 'Nunito Sans',
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      decoration: const InputDecoration(
        labelText: 'Email or Phone',
        labelStyle: TextStyle(
          color: SystemColors.textColor,
          fontFamily: 'Merriweather',
          fontSize: 16,
        ),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextField({super.key, required this.controller});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
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
      controller: widget.controller,
      style: const TextStyle(
        fontFamily: 'Nunito Sans',
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: const TextStyle(
          fontFamily: 'Merriweather',
          color: SystemColors.textColor,
          fontSize: 16,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _togglePasswordVisibility,
        ),
      ),
      obscureText: _obscureText,
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const ForgotPasswordButton({super.key, required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
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
    );
  }
}

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: const TextStyle(
        color: SystemColors.errorColor,
        fontFamily: 'Nunito Sans',
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const LoginButton({super.key, required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.08,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: SystemColors.primaryColorDarker,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21.0),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20.0,
                width: 20.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    SystemColors.accentColor2,
                  ),
                  strokeWidth: 2.0,
                ),
              )
            : const Text(
                'Login',
                style: TextStyle(
                  color: SystemColors.accentColor2,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}

class SignUpRow extends StatelessWidget {
  const SignUpRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            
            // Navigate to Register As screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterAs(),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.zero,
            child: Text('Sign Up'),
          ),
        ),
      ],
    );
  }
}

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              
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
    );
  }
}