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
          DropdownButtonFormField<String>(
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
                width: 100,
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
          DropdownButtonFormField<String>(
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
          RaisedButton(
            onPressed: () async {
              var cityName = _city_selected;
              var cityCode = Helper.getCityCode(_city_selected);
              var interestCode = Helper.getInterestCode(_interest_selected);
              var genderCode = Helper.getGenderCode(_gender_selected);
              var ageCode = Helper.getAgeCode(_age_selected);
              var departureDate =
                  Helper.getFormattedDate(_departureDate_selected);
              var arrivalDate = Helper.getFormattedDate(_arrivalDate_selected);
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
