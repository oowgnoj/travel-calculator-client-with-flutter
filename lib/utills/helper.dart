import 'package:travel_calculator_flutter_client/utills/data.dart';
import 'package:travel_calculator_flutter_client/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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

void setLocal(UserHistory userHistory) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('userName', userHistory.username);
  prefs.setInt('gender', userHistory.gender);
  prefs.setInt('age', userHistory.age);
  prefs.setInt('keyword', userHistory.keyword);
}
// {
//   "username": "aaa",
//   "age": 20,
//   "gender": 2,
//   "keyword": 700,
//   "histories": [
//     {
//       "departuredate": "2019-11-08",
//       "arrivaldate": "2019-11-13",
//       "city": "London",
//       "estimate": "{\"restaurant\":52579,\"hotel\":196753,\"hotelratings\":3,\"nonstopflight\":null,\"flight\":901880,\"total\":2148540}",
//       "photo": "https://images.unsplash.com/photo-1475463606759-53a070b44126?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1061&q=80"
//     }
//   ]
// }
