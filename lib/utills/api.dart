import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:travel_calculator_flutter_client/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:requests/requests.dart';
import 'package:travel_calculator_flutter_client/utills/helper.dart';

String localServer = 'http://3.15.20.155:5000';
// String localServer = 'http://10.0.2.2:5000';
String stageServer = 'http://192.168.35.248:5000';

// generate body

Future<UserHistory> getUser() async {
  print('getuser clicked!');

  final response = await Requests.get(localServer + '/mypage');
  if (response.statusCode == 200) {
    var res = UserHistory.fromJson(response.json());
    setLocal(res);
    return res;
  } else {
    print(response.json());
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

  print('clicked!');

  final response = await Requests.post(localServer + '/signin',
      headers: headers,
      body: {"id": id, "password": password},
      bodyEncoding: RequestBodyEncoding.JSON);

  if (response.statusCode == 200) {
    AlertDialog(title: Text('로그인 성공'));
    return LoginRes.fromJson(response.json());
    // return LoginRes.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('failed to login');
    // If the server did not return a 200 OK response, then throw an exception.
    // return response.body;
    // throw Exception(response);
  }
}

Future<Object> postLogout() async {
  const headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response =
      await Requests.post(localServer + '/signout', headers: headers);

  if (response.statusCode == 200) {
    return true;
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

  var uri = Uri.http(localServer, '/signup');
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
  const headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };
  print(queryParams);

  final response = await Requests.get(localServer + '/calculate',
      queryParameters: queryParams, timeoutSeconds: 60);

  return Calculate.fromJson(response.json());
}
