import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:travel_calculator_flutter_client/utills/api.dart';
import 'package:travel_calculator_flutter_client/utills/helper.dart';
import 'package:travel_calculator_flutter_client/screens/loading.dart';
import 'package:travel_calculator_flutter_client/screens/register.dart';
import 'package:travel_calculator_flutter_client/utills/data.dart';
import 'package:travel_calculator_flutter_client/screens/login.dart';
import 'package:travel_calculator_flutter_client/components/drawer.dart';
import 'package:travel_calculator_flutter_client/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String _city_selected;
  String _gender_selected;
  String _age_selected;
  String _interest_selected;
  DateTime _departureDate_selected;
  DateTime _arrivalDate_selected;
  UserHistory userInfo;

  @override
  // void initState() {
  //   super.initState();
  //   _getUserInfo();
  // }

  // _getUserInfo() async {
  //   final user = await getUser();
  //   setState(() {
  //     userInfo = user;
  //   });
  // }
  // _getUserInfo() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _username = prefs.getInt('age') ?? 0;
  //   });
  // }

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
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Feather.menu),
            color: Colors.black,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: DropdownButtonFormField<String>(
              value: _city_selected,
              decoration: InputDecoration(labelText: 'Please select a city'),
              items: cityMap.map((City value) {
                return new DropdownMenuItem<String>(
                  value: value.cityName,
                  child: new Text(value.cityName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _city_selected = value;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                child: Container(
                  width: 150,
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text(
                            "${_departureDate_selected != null ? _departureDate_selected.toLocal() : '출발일'}"
                                .split(' ')[0]),
                        color: Color(0xFFEEEEEE),
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.grey)),
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                child: Container(
                  width: 150,
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text(
                            "${_arrivalDate_selected != null ? _arrivalDate_selected.toLocal() : '도착일'}"
                                .split(' ')[0]),
                        color: Color(0xFFEEEEEE),
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.grey)),
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
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: DropdownButtonFormField<String>(
                    value: _gender_selected,
                    decoration: InputDecoration(labelText: 'select gender'),
                    items: genderMap.map((String value) {
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
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: DropdownButtonFormField<String>(
                    value: _age_selected,
                    decoration: InputDecoration(labelText: 'select age'),
                    items: ageMap.map((String value) {
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: DropdownButtonFormField<String>(
              value: _interest_selected,
              decoration: InputDecoration(labelText: 'select interest'),
              items: interestMap.map((Interest value) {
                return new DropdownMenuItem<String>(
                  value: value.interestName,
                  child: new Text(value.interestName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _interest_selected = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: new SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: new IconButton(
                icon: new Icon(
                  Icons.flight_takeoff,
                  size: 30,
                ),
                onPressed: () async {
                  var cityName = _city_selected;
                  var cityCode = ConverToCode.getCity(_city_selected);
                  var interestCode =
                      ConverToCode.getInterest(_interest_selected);
                  var genderCode = ConverToCode.getGender(_gender_selected);
                  var ageCode = ConverToCode.getAge(_age_selected);
                  var departureDate =
                      ConverToCode.getFormattedDate(_departureDate_selected);
                  var arrivalDate =
                      ConverToCode.getFormattedDate(_arrivalDate_selected);
                  var userCode = interestCode + genderCode + ageCode;
                  var result = await fetchCalculate(
                      cityName, cityCode, departureDate, arrivalDate, userCode);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Loading(data: result, city: cityName)));
                },
              ),
            ),
          ),
          Container(
              height: 300,
              child: Image(image: AssetImage('assets/main_picture.jpeg')))
        ],
      ),
    );
  }
}
