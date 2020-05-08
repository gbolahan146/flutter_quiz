import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutterquiz/result.dart';

class GetJson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString("assets/quiz.json"),
      builder: (context, snapshot){
        List mydata = jsonDecode(snapshot.data.toString());
        if(mydata == null) {
          return Scaffold(
            body: Center(
              child: Text(
                'Loading'
              ),
            ),
          );
        } else {
          return QuizPage(mydata : mydata);
        }
      },
    );
  }
}

class QuizPage extends StatefulWidget {

  var mydata;
  QuizPage({Key key, @required this.mydata}) : super(key : key);

  @override
  _QuizPageState createState() => _QuizPageState(mydata);
}

class _QuizPageState extends State<QuizPage> {

  var mydata;
  _QuizPageState(this.mydata);

  bool _isButtonDisabled;
  bool _answerSelected;

  int quizNumber;
  int totalQuestion;
  int score = 0;

  Color showColor = Colors.amberAccent;
  Color hideColor = Colors.blue;
  Color wrong = Colors.red;
  Color right = Colors.green;

  Map<String, Color> buttonColor = {
    "a": Colors.amberAccent,
    "b": Colors.amberAccent,
    "c": Colors.amberAccent,
    "d": Colors.amberAccent,
  };

  @override
  void initState() {
    _isButtonDisabled = false;
    _answerSelected = false;
    quizNumber = 1;
    totalQuestion = mydata[0].length;
  }

  void nextQuestion(){
    setState(() {
      if(quizNumber < totalQuestion) {
        quizNumber++;
      } else {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Result(totalScore: score, totalQuestion: totalQuestion,)
        ));
      }
      buttonColor["a"] = Colors.amberAccent;
      buttonColor["b"] = Colors.amberAccent;
      buttonColor["c"] = Colors.amberAccent;
      buttonColor["d"] = Colors.amberAccent;
      _isButtonDisabled = false;
    });
  }

  void checkAnswer(String x) {
    if(mydata[2]['$quizNumber'.toString()] == x) {
      score += 1;
      showColor = wrong;
    } else {
      hideColor = right;
    }
    setState(() {
      buttonColor[x] = showColor;
      buttonColor[mydata[2]['$quizNumber'.toString()]] = right;
      _isButtonDisabled = true;
      _answerSelected = true;
    });
  }

  Widget optionButtons(String x) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: MaterialButton(
        highlightColor: Colors.red,
        splashColor: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        minWidth: 300.0,
        onPressed: () => _isButtonDisabled ? null : checkAnswer(x),
        color: buttonColor[x],
        child: Text(
          mydata[1]['$quizNumber'.toString()][x],
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0
          ),
          maxLines: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Quiz of Life'
            ),
            content: Text(
              'You cannot go back at this point'
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Ok ',
                ),
              )
            ],
          )
        );
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        '$quizNumber of $totalQuestion',
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.amberAccent),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Text(
                        'Your Score: $score',
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.amberAccent),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
                child: Column(
                  children: <Widget>[

                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          mydata[0]['$quizNumber'.toString()],
                          style: TextStyle(color: Colors.black, fontSize: 23.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          optionButtons('a'),
                          optionButtons('b'),
                          optionButtons('c'),
                          optionButtons('d'),
                        ],
                      ),
                    )
                  ],
                ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(

                      topLeft: Radius.circular(25.0),

                      bottomRight: Radius.circular(25.0))
                ),
                child: RaisedButton(

                  color: Colors.deepPurple,
                  onPressed: () => _answerSelected ? nextQuestion() : null,
                  child: Text(
                    'Next Question',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      letterSpacing: 2.0
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}


