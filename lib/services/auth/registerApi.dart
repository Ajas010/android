import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:terefbooking/data/constants.dart';
import 'package:terefbooking/presentation/customeWidgets/snackbar.dart';

ValueNotifier<bool> isRegisterLoading = ValueNotifier(false);

Future<void> registerUserApi(data, context) async {
  final dio = Dio();

  isRegisterLoading.value = true;
  try {
    final response = await dio.post('$baseUrl/publicapp/register/', data: data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Registration Successful: ${response.data}');
      isRegisterLoading.value = false;
      Navigator.pop(context);
      snackbarwidget(context, 'Registration success', Colors.green);
    } else {
      isRegisterLoading.value = false;
      print('Registration Failed: ${response.data}');
      snackbarwidget(context, 'Registration failed', Colors.red);
    }
  } on DioError catch (e) {
    if (e.response != null) {
      isRegisterLoading.value = false;
      print('Server Error: ${e.response?.data}');
      snackbarwidget(context, 'Registration failed', Colors.red);
    } else {
      isRegisterLoading.value = false;
      print('Connection Error: ${e.message}');
      snackbarwidget(context, 'Registration failed', Colors.red);
    }
  }
}
