import 'dart:convert' show jsonDecode;

class City {
  final String city_name;
  final String city_code;

  City(this.city_name, this.city_code);
}

class Interest {
  final String interest_name;
  final int interest_code;
  Interest(this.interest_name, this.interest_code);
}

class Calculate {
  final Estimate estimate;
  final Object details;
  final String day;
  final String cityphoto;

  Calculate({this.estimate, this.details, this.day, this.cityphoto});

  factory Calculate.fromJson(Map<String, dynamic> json) {
    return Calculate(
      estimate: jsonDecode(json)['estimate'],
      details: json['details'] as String,
      day: json['day'] as String,
      cityphoto: json['cityphoto'] as String,
    );
  }
}

class Estimate {
  final int restaurant;
  final int flight;
  final int nonstopflight;
  final int hotel;
  final int hotelratings;
  final int total;

  Estimate(
      {this.restaurant,
      this.flight,
      this.nonstopflight,
      this.hotel,
      this.hotelratings,
      this.total});

  factory Estimate.fromJson(Map<String, dynamic> json) {
    return Estimate(
        restaurant: json['estimate'],
        flight: json['flight'],
        nonstopflight: json['nonstopflight'],
        hotel: json['hotel'],
        hotelratings: json['hotelratings'],
        total: json['total']);
  }
}
