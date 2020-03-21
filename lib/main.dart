import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:travel_calculator_flutter_client/screens/loading.dart';
import 'package:travel_calculator_flutter_client/screens/landing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Landing(),
      onGenerateRoute: (RouteSettings settings) {
        ('build route for ${settings.name}');
        var routes = <String, WidgetBuilder>{
          "loading": (ctx) => Loading(),
          "/": (ctx) => Landing(),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
    );
  }
}
