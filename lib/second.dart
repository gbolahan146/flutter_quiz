import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterquiz/home.dart';

class Secondscreen extends StatefulWidget {

  @override
  _SecondscreenState createState() => _SecondscreenState();
}

class _SecondscreenState extends State<Secondscreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Homepage(),

      )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.lightGreen,
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(

              alignment: Alignment.center,
              width: 400.0,
              child: Text(
                'Welcome to the Quiz of Life',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white
                ),
              ),
            ),
            SizedBox(height: 0.0, ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20.0),
              width: 400.0,
              child: Text(
                'Quiz youself',
                style: TextStyle(fontSize: 18.0, letterSpacing: 4.0, color: Colors.deepPurpleAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
