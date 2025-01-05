import 'package:dio/dio.dart';
import 'package:terefbooking/data/constants.dart';

Future<bool> rentProduct({data}) async {
  final Dio dio = Dio();

  // Replace with your actual API endpoint
  String endpoint = '$baseUrl/publicapp/rentproduct/';

  try {
    final Response response = await dio.post(endpoint, data: data);

    if (response.statusCode == 201 && response.data != null) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    print('Error renting product: $error');
    return false;
  }
}
