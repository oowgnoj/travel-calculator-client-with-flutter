import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:travel_calculator_flutter_client/utills/api.dart';
import 'package:travel_calculator_flutter_client/utills/helper.dart';
import 'package:travel_calculator_flutter_client/loading.dart';
import 'package:travel_calculator_flutter_client/models/models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Landing(),
      onGenerateRoute: (RouteSettings settings) {
        print('build route for ${settings.name}');
        var routes = <String, WidgetBuilder>{
          "loading": (ctx) => Loading(),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  List<City> _cities = [
    City('London', 'LHR'),
    City('Rome', 'FCO'),
    City('Dublin', 'DUB'),
    City('Manchester', 'MAN'),
    City('Porto', 'OPO'),
    City('Warsaw', 'WAW'),
    City('Milan', 'MXP'),
    City('Ankara', 'ESB'),
    City('Singapore', 'SIN'),
    City('Dubai', 'DXB'),
    City('Kuala Lumpur', 'KUL'),
    City('Washington', 'IAD'),
    City('Miami', 'MIA'),
    City('Chicago', 'ORD'),
    City('Sydney', 'SYD'),
  ];
  List<Interest> _interest = [
    Interest('오로라', 100),
    Interest('유적', 200),
    Interest('맛집', 300),
    Interest('미술관', 400),
    Interest('마사지', 500),
    Interest('비치', 600),
    Interest('산림욕', 700),
    Interest('플리마켓', 800),
    Interest('아울렛', 900),
    Interest('쇼핑', 1000),
    Interest('서핑', 1100),
    Interest('캠핑', 1200),
    Interest('호캉스', 1300),
  ];
  List<String> _gender = ['male', 'female'];
  List<String> _age = ['10대', '20대', '30대', '40대', '50대'];

  String _city_selected;
  String _gender_selected;
  String _age_selected;
  String _interest_selected;
  DateTime _departureDate_selected;
  DateTime _arrivalDate_selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFEEEEEE),
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          "Travel Calculator",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Feather.menu,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          DropdownButtonFormField<String>(
            value: _city_selected,
            decoration: InputDecoration(labelText: 'Please select a city'),
            items: _cities.map((City value) {
              return new DropdownMenuItem<String>(
                value: value.city_name,
                child: new Text(value.city_name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _city_selected = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100,
                child: Column(
                  children: <Widget>[
                    Text(
                        "${_departureDate_selected != null ? _departureDate_selected.toLocal() : 'please pick date'}"
                            .split(' ')[0]),
                    RaisedButton(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2022))
                            .then((date) {
                          setState(() {
                            _departureDate_selected = date;
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: 100,
                child: Column(
                  children: <Widget>[
                    Text(
                        "${_arrivalDate_selected != null ? _arrivalDate_selected.toLocal() : 'please pick date'}"
                            .split(' ')[0]),
                    RaisedButton(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2022))
                            .then((date) {
                          setState(() {
                            _arrivalDate_selected = date;
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'select gender'),
                  items: _gender.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _gender_selected = value;
                    });
                  },
                ),
              ),
              Container(
                width: 100,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'select age'),
                  items: _age.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _age_selected = value;
                    });
                  },
                ),
              ),
            ],
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'select interest'),
            items: _interest.map((Interest value) {
              return new DropdownMenuItem<String>(
                value: value.interest_name,
                child: new Text(value.interest_name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _interest_selected = value;
              });
            },
          ),
          RaisedButton(
            onPressed: () async {
              var cityName = _city_selected;
              var cityCode = _cities
                  .where((city) => city.city_name == _city_selected)
                  .toList()[0]
                  .city_code
                  .toString();

              var interestCode = _interest
                  .where((interest) =>
                      interest.interest_name == _interest_selected)
                  .toList()[0]
                  .interest_code;

              var genderCode = _gender_selected == 'female' ? 1 : 2;

              var ageCode = _age_selected != null
                  ? int.parse(_age_selected.substring(1, 2))
                  : '';

              var departureDate =
                  _departureDate_selected.toString().substring(0, 10);
              var arrivalDate =
                  _arrivalDate_selected.toString().substring(0, 10);

              var userCode = interestCode + genderCode + ageCode;
              var result = await fetchCalculate(
                  cityName, cityCode, departureDate, arrivalDate, userCode);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Loading(data: result, city: cityName)));
            },
            child: const Text('calculate', style: TextStyle(fontSize: 20)),
          ),
          Container(
              height: 300,
              child: Image(image: AssetImage('assets/main_picture.jpeg')))
        ],
      ),
    );
  }
}
