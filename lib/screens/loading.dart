import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_calculator_flutter_client/models/models.dart';
import 'package:travel_calculator_flutter_client/components/drawer.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  final Calculate data;
  final String city;
  final dynamic items;
  Loading({this.data, this.city, this.items});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Text _buildRatingStars(dynamic rating) {
    if (!rating.isNaN) {
      String stars = '';
      for (int i = 0; i < rating; i++) {
        stars += '⭐ ';
      }
      stars.trim();
      return Text(stars);
    } else {
      return Text('');
    }
  }

  Widget _buildEstimateCard(IconData icon, int price, String info) {
    return Container(
      margin: EdgeInsets.all(5.0),
      width: 92.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 20.0,
            color: Colors.blueAccent,
          ),
          SizedBox(height: 13.0),
          Text(
            price == null
                ? '정보 없음'
                : price.toString().replaceAllMapped(
                    new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]},'),
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Text(
            info,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              color: Colors.black38,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data == null) {
      return new Scaffold(
        backgroundColor: Colors.blue,
      );
    }
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        /* appBar: AppBar(
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
        ), */
        drawer: MyDrawer(),
        body: Column(children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Hero(
                  tag: widget.data.cityphoto,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.network(
                      widget.data.cityphoto,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.data.estimate.total.toString().replaceAllMapped(
                              new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},') +
                          ' 원',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.7,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.locationArrow,
                          size: 15.0,
                          color: Colors.white70,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          ' ' +
                              widget.city +
                              ' ' +
                              widget.data.day.toString() +
                              '일 예상 경비입니다.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                  itemCount: (widget.items +
                          [widget.data.estimate] +
                          widget.data.details.flight +
                          widget.data.details.hotel +
                          widget.data.details.restaurant)
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    dynamic item = (widget.items +
                        [widget.data.estimate] +
                        widget.data.details.flight +
                        widget.data.details.hotel +
                        widget.data.details.restaurant)[index];
                    if (item is Estimate) {
                      return Container(
                        margin: EdgeInsets.only(top: 8.0, bottom: 5.0),
                        height: 120.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            SizedBox(width: 30.0),
                            _buildEstimateCard(FontAwesomeIcons.planeDeparture,
                                item.flight, '왕복'),
                            _buildEstimateCard(
                                FontAwesomeIcons.hotel, item.hotel, '1일 평균'),
                            _buildEstimateCard(FontAwesomeIcons.utensils,
                                item.restaurant, '1일 평균'),
                          ],
                        ),
                      );
                    } else if (item is Flight) {
                      return Stack(children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                          height: 170.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 100.0,
                                      child: Text(
                                        item.airline,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  item.iternity[0].segments[0].departure.date,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13.0),
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '${item.price.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} ',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      (item.iternity[0].stop.isOdd
                                          ? '경유'
                                          : '직항'),
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20.0,
                          top: 15.0,
                          bottom: 15.0,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(item.logo,
                                  width: 110.0, fit: BoxFit.cover)),
                        )
                      ]);
                    } else if (item is Hotel) {
                      return Stack(children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                          height: 170.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 100.0,
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  item.address,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11.0),
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '${item.price.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} ',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'per night',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                _buildRatingStars(int.parse(item.rating)),
                                SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20.0,
                          top: 15.0,
                          bottom: 15.0,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(item.photo,
                                  width: 110.0, fit: BoxFit.cover)),
                        )
                      ]);
                    } else if (item is Restaurant) {
                      return Stack(children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                          height: 170.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 100.0,
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  item.cuisines,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14.0),
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      item.price,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '2인 평균',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                _buildRatingStars(double.parse(item.rating)),
                                SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20.0,
                          top: 15.0,
                          bottom: 15.0,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(item.photo,
                                  width: 110.0, fit: BoxFit.cover)),
                        )
                      ]);
                    }
                  })),
        ]));
  }
}
