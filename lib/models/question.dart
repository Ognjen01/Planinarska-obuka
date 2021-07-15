import 'package:flutter/material.dart';

class Question{

  String question;
  String correctAnswer;
  String answer1;
  String answer2;
  String answer3;
  String description;
  List<String> answers = [];
  int correctAnswerIndex;
  String illustrationUrl;
  

  Question({
    @required this.question,
    @required this.correctAnswer,
    @required this.answer1,
    @required this.answer2,
    @required this.answer3,
    @required this.description
  }){
    this.answers.add(this.correctAnswer);
    this.answers.add(this.answer1);
    this.answers.add(this.answer2);
    this.answers.add(this.answer3);

    this.answers.sort();
    this.correctAnswerIndex = this.answers.indexOf(this.correctAnswer);

  }
  
}