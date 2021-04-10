import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart';

class FinalPage extends StatelessWidget {
  final int score;
  final VoidCallback callback;
  FinalPage({Key key, @required this.score, @required this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        _buildResult()
    );
  }
  Widget _buildResult(){
    return ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.fromLTRB(0, 150, 0, 0),
              child:Text(
                'Totol Score',
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyle(fontSize:40, fontFamily: "Arial", fontWeight: FontWeight.bold),
              )
          ),
          Container(
              padding: const EdgeInsets.all(8),
              height: 370,
              child:Text(
                score.toString(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: TextStyle(fontSize:40, fontFamily: "Arial", fontWeight: FontWeight.bold),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),

            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    backgroundColor: Colors.lightBlueAccent,
                ),
                onPressed: callback,
                child: Text('Restart',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  style: TextStyle(fontSize:20, fontFamily: "Arial", fontWeight: FontWeight.bold, color: Colors.white),
                ),
            ),
          )
        ]);
  }

}