import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterquiz/quizpage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: new Image.asset(
              'assets/bg.png',
              width: 100.0,
              height: 100.0,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Center(
              child: RaisedButton(
                color: Colors.lightGreen,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => GetJson()
                  ));
                },
                child: Text(
                  'Let\'s Get Started',
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.lightBlue,
    );

  }
}
