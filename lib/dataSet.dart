
import 'dart:convert';
import 'package:flutter/services.dart';
class dataSet{

  dataSet(){
    readJson();
  }
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/quiz.json');
    final quiz = await json.decode(response);
  }

}