import 'package:dio/dio.dart';
import 'package:terefbooking/data/constants.dart';

Future<List<Map<String, dynamic>>> getRentHistory() async {
  final Dio dio = Dio();

  // API endpoint to get booking history
  final String endpoint = '$baseUrl/publicapp/rentinghistory/$loginId/';

  try {
    final Response response = await dio.get(endpoint);
    print(response.data);

    if (response.statusCode == 200 && response.data != null) {
      // Parse response data into a list of maps
      return List<Map<String, dynamic>>.from(response.data);
    } else {
      print('Failed to fetch booking history: ${response.data}');
      return [];
    }
  } catch (error) {
    print('Error fetching booking history: $error');
    return [];
  }
}
