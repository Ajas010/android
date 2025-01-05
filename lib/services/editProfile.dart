import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:terefbooking/data/constants.dart';
import 'package:terefbooking/presentation/customeWidgets/snackbar.dart';
import 'package:terefbooking/presentation/screens/viewProfile.dart';
import 'package:terefbooking/services/getProfileApi.dart';

Future<Map<String, dynamic>> editProfile({
  required String name,
  required String email,
  required String phone,
  required String gender,
  required String address,
  context,
}) async {
  final Dio dio = Dio();

  // Replace with your API endpoint
  String endpoint = '$baseUrl/publicapp/profile/$loginId/';

  try {
    dio.options.headers['Authorization'] =
        'Bearer YOUR_ACCESS_TOKEN'; // Replace with actual token
    final Response response = await dio.put(
      endpoint,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'gender': gender,
        'address': address
      },
    );

    if (response.statusCode == 200 && response.data != null) {
      snackbarwidget(context, 'update success', Colors.green);
      Navigator.pop(context);
      Navigator.pop(context);
      Map<String, dynamic> profile = await getUserProfile(loginId);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileViewScreen(
                    profile: profile,
                  )));

      return {
        'success': true,
        'message': response.data['message'] ?? 'Profile updated successfully',
      };
    } else {
      return {
        'success': false,
        'message': response.data['message'] ?? 'Failed to update profile',
      };
    }
  } catch (error) {
    print('Error editing profile: $error');
    return {
      'success': false,
      'message': 'An error occurred. Please try again later.',
    };
  }
}
