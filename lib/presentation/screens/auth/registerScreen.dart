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
    return GestureDetector(
      // onTap: () {
      //   FocusScope.of(context).unfocus(); // Dismiss keyboard when tapping outside
      // },
      child: Scaffold(
        resizeToAvoidBottomInset: true, // Ensures UI adjusts when keyboard appears
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child:  RegistrationForm(),
         
        ),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _selectedGender = 'Male';
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(false);

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _isPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              CustomTextField(
                controller: _nameController,
                labelText: 'Name',
                hintText: 'Enter your name',
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _usernameController,
                labelText: 'Username',
                hintText: 'Enter your username',
                validator: (value) => value!.isEmpty ? 'Please enter your username' : null,
              ),
              const SizedBox(height: 16),
              GenderSelector(
                onGenderSelected: (gender) {
                  setState(() {
                    _selectedGender = gender;
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _phoneController,
                labelText: 'Phone',
                hintText: 'Enter your phone number',
                keyboardType: TextInputType.phone, // Corrected here
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter your phone number';
                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
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
                keyboardType: TextInputType.emailAddress, // Corrected here
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter your email';
                  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
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
                validator: (value) => value!.isEmpty ? 'Please enter your Place' : null,
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
                      if (value!.isEmpty) return 'Please enter your password';
                      if (value.length < 6) return 'Password must be at least 6 characters';
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
                      ? const Center(child: CircularProgressIndicator())
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
                    Navigator.pop(context);
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ),
          
              // SizedBox(height: 200,)
            ],
          ),
        ),
      ),
    );
  }
}