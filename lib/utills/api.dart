import 'dart:convert';
import 'package:travel_calculator_flutter_client/models/models.dart';
import 'package:http/http.dart' as http;

Future<Calculate> fetchCalculate(
    cityName, cityCode, departureDate, arrivalDate, userCode) async {
  Map<String, String> queryParams = {
    'cityCode': cityCode,
    'departureDate': departureDate,
    'arrivalDate': arrivalDate,
    'code': userCode.toString(),
    'cityName': cityName
  };
  var uri = Uri.http('3.15.20.155:5000', '/calculate', queryParams);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return Calculate.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load Calculate');
  }
}
