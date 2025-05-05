import 'package:flutter/material.dart';
import 'package:terefbooking/data/constants.dart';
import 'package:terefbooking/presentation/customeWidgets/button.dart';
import 'package:terefbooking/presentation/customeWidgets/textfield.dart';
import 'package:terefbooking/presentation/screens/auth/registerScreen.dart';
import 'package:terefbooking/services/auth/loginApi.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();          


  
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          
               SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: appthemeColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
          
          
              CustomTextField(
                controller: _emailController,
                labelText: 'Username',
                hintText: 'Enter your username',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
          
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder<bool>(
                valueListenable: _isPasswordVisible,
                builder: (context, isVisible, child) {
                  return CustomTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    obscureText: !isVisible,
                    isPasswordField: true,
                    onToggleVisibility: () {
                      _isPasswordVisible.value = !_isPasswordVisible.value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              ValueListenableBuilder(
                valueListenable: isLoginLoading,
                builder: (BuildContext context, dynamic value, Widget? child) {
                  return isLoginLoading.value
                      ? Container(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : CustomButton(
                          text: 'Login',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Perform login logic here
                              await loginApi(_emailController.text,
                                  _passwordController.text, context);
                            }
                          },
                        );
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to Registration screen
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctxt) => RegistrationScreen()));
                  },
                  child: const Text('Don\'t have an account? Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
