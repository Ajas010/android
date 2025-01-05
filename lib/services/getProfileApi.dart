import 'package:dio/dio.dart';
import 'package:terefbooking/data/constants.dart';

Future<Map<String, dynamic>> getUserProfile(id) async {
  final dio = Dio();

  try {
    final response = await dio.get('$baseUrl/publicapp/profile/$id/');
    print(response.data);
    if (response.statusCode == 200 ) {
      // Ensure the response data is a list
      return Map<String, dynamic>.from(response.data);
    } 
     else {
      print('Unexpected response format: ${response.data}');
      return {};
    }
  } on DioError catch (e) {
    if (e.response != null) {
      print('Server Error: ${e.response?.data}');
    } else {
      print('Connection Error: ${e.message}');
    }
    return {};
  }
}
