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
  Estimate estimate;
  Object details;
  int day;
  String cityphoto;

  Calculate({this.estimate, this.details, this.day, this.cityphoto});

  factory Calculate.fromJson(Map<String, dynamic> json) {
    return Calculate(
      estimate: Estimate.fromJson(json['estimate']),
      details: json['details'],
      day: json['day'],
      cityphoto: json['cityphoto'],
    );
  }
}

class Estimate {
  String restaurant;
  String flight;
  String nonstopflight;
  String hotel;
  String hotelratings;
  String total;

  // Estimate(Map<String, dynamic> data) {
  //   restaurant = data['restaurant'];
  //   flight = data['flight'];
  //   nonstopflight = data['nonstopflight'];
  //   hotel = data['hotel'];
  //   hotelratings = data['hotelratings'];
  //   total = data['total'];
  // }
  Estimate(
      {this.restaurant,
      this.flight,
      this.nonstopflight,
      this.hotel,
      this.hotelratings,
      this.total});

  factory Estimate.fromJson(Map<String, dynamic> data) {
    return Estimate(
      total: data['total'] as String,
      restaurant: data['restaurant'] as String,
      nonstopflight: data['nonstopflight'] as String,
      hotel: data['hotel'] as String,
      hotelratings: data['hotelratings'] as String,
    );
  }
}

class Restaurant {
  String name;
  String photo;
  String cuisines;
  String price;
  String rating;

  Restaurant({this.name, this.photo, this.cuisines, this.price, this.rating});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      photo: json['photo'],
      cuisines: json['cuisines'],
      rating: json['rating'],
      price: json['price'],
    );
  }
}
