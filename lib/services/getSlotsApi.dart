import 'package:dio/dio.dart';
import 'package:terefbooking/data/constants.dart';

Future<List<Map<String, dynamic>>> getSlots({
  required turfId,
  required String date,
}) async {
  final Dio dio = Dio();

  // Replace with your API endpoint
  const String endpoint = '$baseUrl/publicapp/availableslots/';

  try {
    final Response response = await dio.get(
      endpoint,
      queryParameters: {
        'turf_id': turfId,
        'booking_date': date,
      },
    );
    print(response.data);

    if (response.statusCode == 200 && response.data != null) {
      final List<dynamic> slots =
          response.data; // Assuming "slots" key in response
      print(response.data[0]['status']);
      return slots.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load slots');
    }
  } catch (error) {
    print('Error fetching slots: $error');
    return [];
  }
}
