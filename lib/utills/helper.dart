import 'package:travel_calculator_flutter_client/utills/data.dart';

class Helper {
  static String getCityCode(citySelected) {
    return cityMap
        .where((city) => city.cityName == citySelected)
        .toList()[0]
        .cityCode
        .toString();
  }

  static int getInterestCode(interestSelected) {
    return interestMap
        .where((interest) => interest.interestName == interestSelected)
        .toList()[0]
        .interestCode;
  }

  static int getGenderCode(genderSelected) {
    return genderSelected == 'female' ? 1 : 2;
  }

  static int getAgeCode(genderSelected) {
    return genderSelected != null
        ? int.parse(genderSelected.substring(1, 2))
        : '';
  }

  static String getFormattedDate(date) {
    return date.toString().substring(0, 10);
  }
}
