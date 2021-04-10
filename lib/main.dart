import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/dataSet.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'final_page.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home:
      MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _score = 0;
  dataSet dataset = new dataSet();
  final total_questions = 3;
  int questionDone = 0;
  String _name1 = "Duck";
  String _name2 = "Whale";
  String _name3 = "Shark";
  String _name4 = "Butterfly";
  String _question = "Which of the following is a mammal?";
  String _anwser = "Whale";
  double _percentage = 0.0;
  Color _color1 = Colors.grey[300];
  Color _color2 = Colors.grey[300];
  Color _color3 = Colors.grey[300];
  Color _color4 = Colors.grey[300];
  String _image1 = 'assets/duck.PNG';
  String _image2 = 'assets/Whale.png';
  String _image3 = 'assets/Shark.PNG';
  String _image4 = 'assets/Butterfly.PNG';
  String _explaination = "Whales are mammals. Mammals are characterized by the presence of mammary glands in which females produce milk for feeding their young.";
  Flushbar flush;
  void _incrementScore() {
    setState(() {
      _score++;
    });
  }
  void _updateQuiz() {
    readJson();
  }
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/quiz.json');
    final quiz = await json.decode(response);

    setState(() {
      _name1 = quiz[questionDone]['Options'][0];
      _name2 = quiz[questionDone]['Options'][1];
      _name3 = quiz[questionDone]['Options'][2];
      _name4 = quiz[questionDone]['Options'][3];
      _question = quiz[questionDone]['question'];
      _anwser = quiz[questionDone]['answer'];
      _color1 = Colors.grey[300];
      _color2 = Colors.grey[300];
      _color3 = Colors.grey[300];
      _color4 = Colors.grey[300];
      _image1 = quiz[questionDone]['images'][0];
      _image2 = quiz[questionDone]['images'][1];
      _image3 = quiz[questionDone]['images'][2];
      _image4 = quiz[questionDone]['images'][3];
      _explaination = quiz[questionDone]['Explanation'];
    });
  }
  void showFlushbar(BuildContext context){
    flush = Flushbar(
      backgroundColor: Colors.blue[900],
      titleText: Text(
        "Explanation",
        textAlign: TextAlign.left,
        overflow: TextOverflow.visible,
        style: TextStyle(fontSize:30, fontFamily: "Arial", fontWeight: FontWeight.bold, color: Colors.white),
      ),
        messageText: Text(
          _explaination,
          textAlign: TextAlign.left,
          overflow: TextOverflow.visible,
          style: TextStyle(fontSize:15, fontFamily: "Arial", fontWeight: FontWeight.bold, color: Colors.white),
        ),

        mainButton: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26.0),
            ),
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            flush.dismiss();
            if(questionDone!=total_questions){
              _updateQuiz();
            }else{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FinalPage(score: _score, callback: resetQuiz,)),
              );
            }
          },
          child: Text('Continue',
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            style: TextStyle(fontSize:15, fontFamily: "Arial", fontWeight: FontWeight.bold, color: Colors.black),
          ),

        ),
        duration: null,
        isDismissible:true,
    );
        flush..show(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_buildQuestion()
    );
      //

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.

  }
  Widget _buildQuestion(){
    return ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          new Row(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 120,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 0,
                  percent: _percentage,
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.greenAccent,
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(8),
                  child:new Column(
                    children: [
                        Text(
                        "Score",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        style: TextStyle(fontSize:18, fontFamily: "Arial", fontWeight: FontWeight.bold),
                        ),
                        Text(
                        "$_score",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        style: TextStyle(fontSize:18, fontFamily: "Arial", fontWeight: FontWeight.bold),
                        ),
                  ],
                ),
              )
          ]),
          Container(
              padding: const EdgeInsets.all(8),
              child:Text(
                '$_question',
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyle(fontSize:40, fontFamily: "Arial", fontWeight: FontWeight.bold),
              )
          ),
        _buildImages(),
      ]);
  }
  Widget _buildImages(){
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
      shrinkWrap: true, // You won't see infinite size error
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              setState(() {
                questionDone++;
                _percentage = questionDone/total_questions;
                if(_name1 == _anwser){
                  _color1 = Colors.green[400];
                  _incrementScore();
                  if(questionDone!=total_questions){
                    _updateQuiz();
                  }else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FinalPage(score: _score, callback: resetQuiz,)),
                    );
                  }
                }else{
                  _color1 = Colors.red[400];
                  if(_name2==_anwser){
                    _color2 = Colors.green[400];
                  }
                  if(_name3==_anwser){
                    _color3 = Colors.green[400];
                  }
                  if(_name4==_anwser){
                    _color4 = Colors.green[400];
                  }
                  showFlushbar(context);
                }
              });
            },

            child: new  Column(
              children: [
                new Container(
                    child: Text(
                        '$_name1',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize:30, fontFamily: "Arial", fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.all(10)
                  ),
                new Container(
                  child: Image.asset(_image1,height: 100),
                ),
            ]),
          ),
          color: _color1,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              setState(() {
                questionDone++;
                _percentage = questionDone/total_questions;
                if(_name2 == _anwser){
                  _color2 = Colors.green[400];
                  _incrementScore();
                  if(questionDone!=total_questions){
                    _updateQuiz();
                  }else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FinalPage(score: _score, callback: resetQuiz,)),
                    );
                  }
                }else{
                  _color2 = Colors.red[400];
                  if(_name1==_anwser){
                    _color1 = Colors.green[400];
                  }
                  if(_name3==_anwser){
                    _color3 = Colors.green[400];
                  }
                  if(_name4==_anwser){
                    _color4 = Colors.green[400];
                  }
                  showFlushbar(context);
                }
              });
            },

            child: new  Column(
                children: [
                  new Container(
                      child: Text(
                        '$_name2',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize:30, fontFamily: "Arial", fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.all(10)
                  ),
                  new Container(
                    child: Image.asset(_image2, height: 100),
                  ),
                ])
            ),
            color: _color2,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  questionDone++;
                  _percentage = questionDone/total_questions;
                  if(_name3 == _anwser){
                    _color3 = Colors.green[400];
                    _incrementScore();
                    if(questionDone!=total_questions){
                      _updateQuiz();
                    }else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FinalPage(score: _score, callback: resetQuiz,)),
                      );
                    }
                  }else{
                    _color3 = Colors.red[400];
                    if(_name1==_anwser){
                      _color1 = Colors.green[400];
                    }
                    if(_name2==_anwser){
                      _color2 = Colors.green[400];
                    }
                    if(_name4==_anwser){
                      _color4 = Colors.green[400];
                    }
                    showFlushbar(context);
                  }
                });
              },
            child: new  Column(
              children: [
                new Container(
                    child: Text(
                      '$_name3',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize:30, fontFamily: "Arial", fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.all(10)
                ),
                new Container(
                  child: Image.asset(_image3,height: 100),
                ),
                ]),
              ),
          color: _color3,
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  questionDone++;
                  _percentage = questionDone/total_questions;
                  if(_name4 == _anwser){
                    _color4 = Colors.green[400];
                    _incrementScore();
                    if(questionDone!=total_questions){
                      _updateQuiz();
                    }else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FinalPage(score: _score, callback: resetQuiz,)),
                      );
                    }
                  }else{
                    _color4 = Colors.red[400];
                    if(_name2==_anwser){
                      _color2 = Colors.green[400];
                    }
                    if(_name3==_anwser){
                      _color3 = Colors.green[400];
                    }
                    if(_name1==_anwser){
                      _color1 = Colors.green[400];
                    }
                    showFlushbar(context);
                  }
                });
              },
            child: new  Column(
              children: [
                new Container(
                    child: Text(
                      '$_name4',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize:30, fontFamily: "Arial", fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.all(10)
                ),
                new Container(
                    child: Image.asset(_image4,height: 100),
                ),
              ]),
          ),
          color: _color4,
        ),
      ],
    );
  }
  void resetQuiz() {
    if (Navigator.canPop(context)) Navigator.pop(context);

    setState(() {
       _score = 0;
       questionDone = 0;
       _name1 = "Duck";
       _name2 = "Whale";
       _name3 = "Shark";
       _name4 = "Butterfly";
      _question = "Which of the following is a mammal?";
       _anwser = "Whale";
      _percentage = 0.0;
       _color1 = Colors.grey[300];
       _color2 = Colors.grey[300];
       _color3 = Colors.grey[300];
       _color4 = Colors.grey[300];
      _image1 = 'assets/duck.PNG';
      _image2 = 'assets/Whale.png';
       _image3 = 'assets/Shark.PNG';
       _image4 = 'assets/Butterfly.PNG';
       _explaination = "Whales are mammals. Mammals are characterized by the presence of mammary glands in which females produce milk for feeding their young.";
    });
  }
}
