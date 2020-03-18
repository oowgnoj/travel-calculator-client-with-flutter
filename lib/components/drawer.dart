import 'package:flutter/material.dart';
import 'package:travel_calculator_flutter_client/Main.dart';
import 'package:travel_calculator_flutter_client/screens/login.dart';
import 'package:travel_calculator_flutter_client/screens/landing.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                      backgroundColor: Colors.brown.shade800,
                      child: Text(
                        'AH',
                        style: TextStyle(color: Colors.white),
                      )),
                  Text(
                    'Drawer Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'Drawer Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              )),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('home'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.face),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          ),
        ],
      ),
    );
  }
}
