import 'package:flutter/material.dart';

class Question{

  String question;
  String correctAnswer;
  String answer1;
  String answer2;
  String answer3;
  String description;
  

  Question({
    @required this.question,
    @required this.correctAnswer,
    @required this.answer1,
    @required this.answer2,
    @required this.answer3,
    @required this.description
  });
  
}