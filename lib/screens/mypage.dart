import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_calculator_flutter_client/components/drawer.dart';
import 'package:travel_calculator_flutter_client/utills/api.dart';
import 'package:travel_calculator_flutter_client/utills/data.dart';
import 'package:travel_calculator_flutter_client/models/models.dart';
import 'package:travel_calculator_flutter_client/screens/register.dart';
import 'package:travel_calculator_flutter_client/screens/login.dart';

class Mypage extends StatefulWidget {
  Mypage({Key key}) : super(key: key);

  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  Future<UserHistory> userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = getUser();
  }

  _buildUserCard(UserHistory info) {
    return Container(
      height: 140.0,
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.laughWink,
            size: 32.0,
            color: Colors.black,
          ),
          Text(
            'welcome , ' + info.username,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  _buildHistoryCard(History history, int index) {
    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 220.0,
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(history.photo),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(60.0),
            padding: EdgeInsets.all(10.0),
            color: Colors.white70,
            child: Column(
              children: <Widget>[
                Text(
                  history.city,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  history.departuredate + ' ~ ' + history.arrivaldate,
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  history.estimate.total.toString().replaceAllMapped(
                          new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => '${m[1]},') +
                      '원',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
            'Travel Calculator',
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
        body: Center(
            child: FutureBuilder<UserHistory>(
          future: userInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.histories.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return _buildUserCard(snapshot.data);
                    }
                    History history = snapshot.data.histories[index - 1];
                    return _buildHistoryCard(history, index);
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        )));
  }
}
