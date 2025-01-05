import 'package:flutter/material.dart';
import 'package:terefbooking/data/constants.dart';
import 'package:terefbooking/presentation/customeWidgets/button.dart';
import 'package:terefbooking/presentation/customeWidgets/genderSlect.dart';
import 'package:terefbooking/presentation/customeWidgets/textfield.dart';
import 'package:terefbooking/services/auth/registerApi.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Text(
                'REGISTER',
                style: TextStyle(
                  color: appthemeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RegistrationForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationForm extends StatelessWidget {
  RegistrationForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _usernameController = TextEditingController();
  String _selectedGender = 'Male';
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            controller: _nameController,
            labelText: 'Name',
            hintText: 'Enter your name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _usernameController,
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
          GenderSelector(
            onGenderSelected: (gender) {
              _selectedGender = gender;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _phoneController,
            labelText: 'Phone',
            hintText: 'Enter your phone number',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                return 'Please enter a valid 10-digit phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _emailController,
            labelText: 'Email',
            hintText: 'Enter your email',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _addressController,
            labelText: 'Place',
            hintText: 'Enter your Place',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Place';
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
            valueListenable: isRegisterLoading,
            builder: (BuildContext context, dynamic value, Widget? child) {
              return isRegisterLoading.value
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : CustomButton(
                      text: 'Register',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> data = {
                            'name': _nameController.text,
                            'email': _emailController.text,
                            'password': _passwordController.text,
                            'username': _usernameController.text,
                            'phone': _phoneController.text,
                            'gender': _selectedGender,
                            'address': _addressController.text,
                          };
                          // Perform registration logic here
                          await registerUserApi(data, context);
                        }
                      },
                    );
            },
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {
                // Navigate back to Login screen
                Navigator.pop(context);
              },
              child: const Text('Already have an account? Login'),
            ),
          ),
        ],
      ),
    );
  }
}
