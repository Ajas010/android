import 'package:dio/dio.dart';
import 'package:terefbooking/data/constants.dart';

Future<List<Map<String, dynamic>>> getTurfs() async {
  final dio = Dio();

  try {
    final response = await dio.get('$baseUrl/publicapp/allturfs/');
    print(response.data);

    if (response.statusCode == 200 && response.data is List) {
      // Ensure the response data is a list
      return List<Map<String, dynamic>>.from(response.data);
    } else if (response.statusCode == 200 && response.data is Map) {
      // If a single object is returned, wrap it in a list
      return [Map<String, dynamic>.from(response.data)];
    } else {
      print('Unexpected response format: ${response.data}');
      return [];
    }
  } on DioError catch (e) {
    if (e.response != null) {
      print('Server Error: ${e.response?.data}');
    } else {
      print('Connection Error: ${e.message}');
    }
    return [];
  }
}
