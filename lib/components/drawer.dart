import 'package:flutter/material.dart';
import 'package:travel_calculator_flutter_client/Main.dart';
import 'package:travel_calculator_flutter_client/models/models.dart';
import 'package:travel_calculator_flutter_client/screens/login.dart';
import 'package:travel_calculator_flutter_client/screens/landing.dart';
import 'package:travel_calculator_flutter_client/screens/mypage.dart';
import 'package:travel_calculator_flutter_client/utills/api.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future: getUser(),
      builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Drawer();
        } else if (snapshot.hasError) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'please login ..',
                          style: TextStyle(
                            color: Colors.black,
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
                  leading: Icon(Icons.contact_mail),
                  title: Text('login'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                ),
              ],
            ),
          );
        } else {
          UserHistory userInfo = snapshot.data;
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
                              userInfo.username,
                              style: TextStyle(color: Colors.white),
                            )),
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
                    print('mypage');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Mypage()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () async {
                    postLogout();
                    Navigator.pushNamed(context, '/');
                    _showAlert(context);
                  },
                ),
              ],
            ),
          ); // sna
        }
      },
    );
  }
}

void _showAlert(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("로그아웃"),
            content: Text("로그아웃 되었습니다."),
          ));
}
