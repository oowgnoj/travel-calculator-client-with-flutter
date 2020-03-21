import 'dart:convert' show jsonDecode;

class LoginRes {
  int keyword;
  int age;
  int gender;

  LoginRes({
    this.keyword,
    this.age,
    this.gender,
  });

  factory LoginRes.fromJson(dynamic json) {
    return LoginRes(
        keyword: json['keyword'], age: json['age'], gender: json['gender']);
  }
}

class City {
  final String cityName;
  final String cityCode;

  City(this.cityName, this.cityCode);
}

class Interest {
  final String interestName;
  final int interestCode;
  Interest(this.interestName, this.interestCode);
}

class Calculate {
  Estimate estimate;
  Details details;
  int day;
  String cityphoto;

  Calculate({this.estimate, this.details, this.day, this.cityphoto});

  factory Calculate.fromJson(dynamic json) {
    return Calculate(
      estimate: Estimate.fromJson(json['estimate']),
      details: Details.fromJson(json['details']),
      day: json['day'],
      cityphoto: json['cityphoto'],
    );
  }
}

class Estimate {
  int restaurant;
  int flight;
  int nonstopflight;
  int hotel;
  int hotelratings;
  int total;

  Estimate(
      {this.restaurant,
      this.flight,
      this.nonstopflight,
      this.hotel,
      this.hotelratings,
      this.total});

  factory Estimate.fromJson(dynamic json) {
    return Estimate(
      total: json['total'],
      restaurant: json['restaurant'],
      nonstopflight: json['nonstopflight'],
      hotel: json['hotel'],
      hotelratings: json['hotelratings'],
    );
  }
}

// details : {<Map>flight, <Map>hotel, <Map> Restaurant}
class Details {
  List<Flight> flight;
  List<Hotel> hotel;
  List<Restaurant> restaurant;
  Details({this.hotel, this.flight, this.restaurant});

  factory Details.fromJson(dynamic json) {
    var flist = json['flight'] as List;
    List<Flight> flightList = flist.map((i) => Flight.fromJson(i)).toList();

    var list = json['restaurant'] as List;
    List<Restaurant> restaurantList =
        list.map((i) => Restaurant.fromJson(i)).toList();

    var hList = json['hotel'] as List;
    List<Hotel> hotelList = hList.map((i) => Hotel.fromJson(i)).toList();

    return Details(
        flight: flightList, hotel: hotelList, restaurant: restaurantList);
  }
}

class Flight {
  int offerid;
  List<Iternity> iternity;
  String price;
  String airline;
  String logo;

  Flight({this.offerid, this.iternity, this.price, this.airline, this.logo});

  factory Flight.fromJson(dynamic json) {
    var list = json['itineraries'] as List;
    List<Iternity> iternityList =
        list.map((i) => Iternity.fromJson(i)).toList();

    return Flight(
      offerid: json['offerid'],
      iternity: iternityList,
      price: json['price'],
      airline: json['airline'],
      logo: json['logo'],
    );
  }
}
// <Map>Flight : {String offerid, Map Iternity, Int price, String airline, String logo}

class Iternity {
  String duration;
  int stop;
  List<Segment> segments;

  Iternity({this.duration, this.stop, this.segments});
  factory Iternity.fromJson(Map<String, dynamic> json) {
    var list = json['segments'] as List;
    List<Segment> segmentList = list.map((i) => Segment.fromJson(i)).toList();

    return Iternity(
      duration: json['duration'],
      stop: json['stop'],
      segments: segmentList,
    );
  }
}

class Segment {
  FlightInfo departure;
  FlightInfo arrival;
  String duration;

  Segment({this.departure, this.arrival, this.duration});
  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
        arrival: FlightInfo.fromJson(json['arrival']),
        departure: FlightInfo.fromJson(json['departure']),
        duration: json['duration']);
  }
}

class FlightInfo {
  String city;
  String date;

  FlightInfo({this.city, this.date});
  // FlightInfo('seoul', '오늘')  // => {'seoul', '오늘'}
  // FlightInfo.fromJson({city: 'seoul', date: '오늘'});
  // flightinfo의 instance 를 만들어서 부모(segment)의
  // departure, arrival 에 넣어줘야 하는데,
  // json 그대로 넣게 되면 형태는 똑같이 보여도,
  // class 의 instance 가 아니기 때문에 안된다

  factory FlightInfo.fromJson(dynamic json) {
    return FlightInfo(city: json['city'], date: json['date']);
  }
}

class Hotel {
  String name;
  String rating;
  String photo;
  int price;
  String adress;
  String room;

  Hotel(
      {this.name, this.rating, this.photo, this.price, this.adress, this.room});
  factory Hotel.fromJson(dynamic json) {
    return Hotel(
        adress: json['adress'],
        rating: json['rating'],
        name: json['name'],
        photo: json['photo'],
        price: json['price'].toInt(),
        room: json['roon']);
  }
}

class Restaurant {
  String name;
  String photo;
  String cuisines;
  String price;
  String rating;

  Restaurant({this.name, this.photo, this.cuisines, this.price, this.rating});
// list ->  각각parsing
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
