import 'package:dio/dio.dart';
import 'package:terefbooking/data/constants.dart';

Future<bool> cancelBooking({id}) async {
  final Dio dio = Dio();

  // Replace with your actual API endpoint
  String endpoint = '$baseUrl/publicapp/cancelbooking/';

  try {
    final Response response = await dio.post(endpoint,data: {'booking_id':id,'user_id':loginId});

    if (response.statusCode == 201 && response.data != null) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    print('Error canceling : $error');
    return false;
  }
}
