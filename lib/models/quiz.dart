import 'package:flutter/material.dart';
import 'package:planinarska_obuka/models/question.dart';

class Quiz {
  String nameOfQuiz;
  String coverPhotoUrl;
  List<Question> listOfQuestions = [];

  Quiz(
      {@required this.nameOfQuiz,
      @required this.coverPhotoUrl,
      });
}
