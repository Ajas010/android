import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:terefbooking/data/constants.dart';
import 'package:terefbooking/presentation/customeWidgets/snackbar.dart';
import 'package:terefbooking/presentation/screens/homeScreen.dart';
import 'package:terefbooking/services/getTurfsApi.dart';

final Dio _dio = Dio();

ValueNotifier<bool> isLoginLoading = ValueNotifier(false);

Future<void> loginApi(String email, String password, context) async {
  isLoginLoading.value = true;
  try {
    // Endpoint for login

    // API Request Body

    final data = {
      "username": email,
      "password": password,
    };

    // Sending POST request
    final response = await _dio.post('$baseUrl/loginapi/', data: data);

    // Check for success status
    if (response.statusCode == 200) {
      // Return response data
      print(response.data);
      if (response.data['status'] == true) {
        isLoginLoading.value = false;
        loginId = response.data['session_data']['user_id'].toString();
        // snackbarwidget(context, 'Login success', Colors.green);
        List<Map<String, dynamic>> turfdata = await getTurfs();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctxt) => HomeScreen(
                      turfs: turfdata,
                    )));
      } else {
        isLoginLoading.value = false;
        snackbarwidget(context, 'invalid credentials', Colors.red);
      }
    } else {
      // Handle error response
      isLoginLoading.value = false;
      snackbarwidget(context, 'Login failed', Colors.red);
      throw Exception("Login failed with status code: ${response.statusCode}");
    }
  } on DioError catch (e) {
    // Handle Dio-specific errors
    if (e.response != null) {
      isLoginLoading.value = false;
      snackbarwidget(context, 'Login failed', Colors.red);
      // Server-side error
      throw Exception("Server Error: ${e.response?.data['message']}");
    } else {
      // Connection or other errors
      isLoginLoading.value = false;
      snackbarwidget(context, 'Login failed', Colors.red);
      throw Exception("Connection Error: ${e.message}");
    }
  } catch (e) {
    // Handle general errors
    isLoginLoading.value = false;
    snackbarwidget(context, 'Login failed', Colors.red);
    throw Exception("An error occurred: $e");
  }
}
