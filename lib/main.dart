import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:travel_calculator_flutter_client/utills/api.dart';

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
    );
  }
}

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  List<String> _cities = [
    '런던',
    '로마',
    '밀라노',
    '더블린',
    '브라티슬라바',
    '포르토',
    '바르샤바',
    '앙카라',
    '싱가포르',
    '두바이',
    '쿠알라룸푸르',
    '워싱톤',
    '마이애미',
    '시카고',
    '시드니',
  ];
  List<String> _interest = [
    '오로라',
    '유적',
    '맛집',
    '미술관',
    '마사지',
    '비치',
    '산림욕',
    '플리마켓',
    '아울렛',
    '쇼핑',
    '서핑',
    '캠핑',
    '호캉스',
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
            items: _cities.map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
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
            items: _interest.map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _interest_selected = value;
              });
            },
          ),
          RaisedButton(
            onPressed: () {
              fetchCalculate();
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
