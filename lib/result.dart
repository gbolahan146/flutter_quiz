import 'package:flutter/material.dart';
import 'package:flutterquiz/home.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final int totalQuestion;
  double percent;

  Result({ Key key, @required this.totalScore, @required this.totalQuestion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Congratulations you scored $totalScore out of $totalQuestion correct answers',
                style: TextStyle(fontSize: 30.0, color: Colors.black),
              ),
              SizedBox(height: 20.0,),
              Container(
                padding: EdgeInsets.all(20.0),
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.all(
                    Radius.circular(150.0)
                  )
                ),
                child: Center(
                  child: Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(140.0))

                    ),
                    child: Center(
                      child: Text(
                        '${((totalScore / totalQuestion) * 100).round()}' + '%',
                        style: TextStyle(fontSize:  30.0, color: Colors.lightGreen),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.0,),
              RaisedButton(

                padding: EdgeInsets.all(15.0),
                color: Colors.deepPurple,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Homepage()
                  )
                  );
                },
                child: Text(
                  'Re-take Quiz ',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}