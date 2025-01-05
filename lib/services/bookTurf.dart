import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:terefbooking/data/constants.dart';
import 'package:terefbooking/presentation/customeWidgets/snackbar.dart';

Future<bool> bookTurf({
  required turfId,
  required userId,
  required date,
  required slotid,
  required amount,
  required BuildContext context,
}) async {
  final Dio dio = Dio();

  // Replace with your API endpoint
  final String endpoint = '$baseUrl/publicapp/bookturf/';

  try {
    final Response response = await dio.post(
      endpoint,
      data: {
        'turf_id': turfId,
        'user_id': userId,
        'booking_date': date,
        'slot_id': slotid,
        // 'amount': amount,
      },
    );
    print(response.data);

    if (response.statusCode == 201 && response.data != null) {
      snackbarwidget(context, 'Booking successful!', Colors.green);
      return true;
      // return {
      //   'success': true,
      //   'message': response.data['message'] ?? 'Booking created successfully',
      //   'data': response.data,
      // };
    } else {
      snackbarwidget(context, 'Failed to book turf', Colors.red);
      return false;
      // return {
      //   'success': false,
      //   'message': response.data['message'] ?? 'Booking failed',
      // };
    }
  } catch (error) {
    print('Error booking turf: $error');
    snackbarwidget(
        context, 'An error occurred. Please try again later.', Colors.red);
    return false;
    // return {
    //   'success': false,
    //   'message': 'An error occurred. Please try again later.',
    // };
  }
}
