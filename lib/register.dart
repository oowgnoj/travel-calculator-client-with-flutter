import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:travel_calculator_flutter_client/utills/api.dart';
import 'package:travel_calculator_flutter_client/utills/data.dart';
import 'package:travel_calculator_flutter_client/models/models.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  String _interestSelected;
  String _ageSelected;
  String _genderSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
          icon: Icon(
            Feather.menu,
            color: Colors.black,
          ),
        ),
      ),
      drawer: Drawer(
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
              leading: Icon(Icons.message),
              title: Text('Messages'),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Register()));
              },
            ),
            //  Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) =>
            //               Loading(data: result, city: cityName)));
            // },
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('email'),
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Text('password'),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _ageSelected,
                decoration: InputDecoration(labelText: 'select age'),
                items: ageMap.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _ageSelected = value;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: _interestSelected,
                decoration: InputDecoration(labelText: 'select interest'),
                items: interestMap.map((Interest value) {
                  return new DropdownMenuItem<String>(
                    value: value.interestName,
                    child: new Text(value.interestName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _interestSelected = value;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: _genderSelected,
                decoration: InputDecoration(labelText: 'select gender'),
                items: genderMap.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _genderSelected = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState.validate()) {
                      String id = _idController.text;
                      String password = _passwordController.text;
                      postSignin(id, password, _genderSelected, _ageSelected,
                          _interestSelected);
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
