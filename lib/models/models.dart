class Calculate {
  final Object estimate;
  final Object details;
  final String day;
  final String cityphoto;

  Calculate({this.estimate, this.details, this.day, this.cityphoto});

  factory Calculate.fromJson(Map<String, dynamic> json) {
    return Calculate(
      estimate: json['estimate'],
      details: json['details'],
      day: json['day'],
      cityphoto: json['cityphoto'],
    );
  }
}
