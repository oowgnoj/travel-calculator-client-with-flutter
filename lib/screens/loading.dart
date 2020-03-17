import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:travel_calculator_flutter_client/models/models.dart';
import 'package:travel_calculator_flutter_client/components/drawer.dart';
import 'dart:convert';

class Loading extends StatelessWidget {
  final Calculate data;
  final String city;
  Loading({this.data, this.city});

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return new Scaffold(
        backgroundColor: Colors.blue,
      );
    }
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFEEEEEE),
          brightness: Brightness.light,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Feather.menu,
              color: Colors.black,
            ),
          ),
        ),
        drawer: MyDrawer(),
        body: Column(
          children: <Widget>[
            Image.network(data.cityphoto),
            Text(
              data.day.toString() +
                  '일 ' +
                  city +
                  ' 여행 경비로는 ' +
                  data.estimate.total.toString() +
                  '원 이 예상됩니다.',
              style: TextStyle(fontSize: 20),
            )
          ],
        ));
  }
}
