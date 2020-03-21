import 'package:travel_calculator_flutter_client/utills/data.dart';

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
