import 'package:travel_calculator_flutter_client/utills/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConverToCode {
  static String getCity(citySelected) {
    return cityMap
        .where((city) => city.cityName == citySelected)
        .toList()[0]
        .cityCode
        .toString();
  }

  static int getInterest(interestSelected) {
    return interestMap
        .where((interest) => interest.interestName == interestSelected)
        .toList()[0]
        .interestCode;
  }

  static int getGender(genderSelected) {
    return genderSelected == 'female' ? 1 : 2;
  }

  static int getAge(genderSelected) {
    return genderSelected != null
        ? int.parse(genderSelected.substring(1, 2))
        : '';
  }

  static String getFormattedDate(date) {
    return date.toString().substring(0, 10);
  }
}

class Session {
  static Map<String, String> headers = {};

  static Future<Map> get(dynamic url) async {
    http.Response response = await http.get(url, headers: headers);
    updateCookie(response);
    return jsonDecode(response.body);
  }

  static Future<Map> post(String url, dynamic data) async {
    http.Response response = await http.post(url, body: data, headers: headers);
    updateCookie(response);
    return jsonDecode(response.body);
  }

  static void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}
