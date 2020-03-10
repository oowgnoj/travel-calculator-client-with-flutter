import 'dart:convert';
import 'package:travel_calculator_flutter_client/models/models.dart';
import 'package:http/http.dart' as http;

Future<Calculate> fetchCalculate() async {
  final response = await http.get(
      'http://3.15.20.155:5000/calculate?cityCode=LHR&departureDate=2019-11-10&arrivalDate=2019-11-20&cityName=London&code=151');

  if (response.statusCode == 200) {
    print(response.body);
    return Calculate.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load Calculate');
  }
}
