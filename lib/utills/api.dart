import 'dart:convert';
import 'package:travel_calculator_flutter_client/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:requests/requests.dart';

// generate body

Future<Object> getUser() async {
  const headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await Requests.get('http://192.168.35.248:5000/mypage');
  if (response.statusCode == 200) {
    print('res!!!!!');
    print(response.json());
    // return LoginRes.fromJson(jsonDecode(response.body));
  } else {
    print(response.json());
    // throw Exception('failed to login');
    // If the server did not return a 200 OK response, then throw an exception.
    // return response.body;
    // throw Exception(response);
  }
}

Future<Object> postLogin(id, password) async {
  Map<String, String> json = {
    "id": id,
    "password": password,
  };

  const headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await Requests.post('http://192.168.35.248:5000/signin',
      headers: headers,
      body: {"id": id, "password": password},
      bodyEncoding: RequestBodyEncoding.JSON);
  if (response.statusCode == 200) {
    return LoginRes.fromJson(response.json());
    // return LoginRes.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('failed to login');
    // If the server did not return a 200 OK response, then throw an exception.
    // return response.body;
    // throw Exception(response);
  }
}

Future<Object> postSignin(id, password, gender, age, interest) async {
  Map<String, String> json = {
    'id': id,
    'password': password,
    'gender': gender,
    'age': age,
    'keyword': interest
  };
  const headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  var uri = Uri.http('3.15.20.155:5000', '/signup');
  final response =
      await http.post(uri, headers: headers, body: jsonEncode(json));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('failed to sign up');
    // throw Exception(response.body);
    // If the server did not return a 200 OK response, then throw an exception.
    // throw Exception(response.error);
  }
}

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
