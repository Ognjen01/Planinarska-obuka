import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planinarska_obuka/controllers/question_controller.dart';
import 'package:planinarska_obuka/models/question.dart';
import 'package:planinarska_obuka/models/quiz.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:planinarska_obuka/widgets/question_widget.dart';

class QuestionScreen extends StatelessWidget {
  User currenUser;
  Quiz selectedQUiz;
  List<Question> questions = [];

  QuestionScreen({@required this.currenUser, @required this.selectedQUiz}) {
    // Algorythm takes 10 random questions from list of all qestions in quiz:

    for (var i = 0; i < 10; i++) {
      int min = 0;
      int max = selectedQUiz.listOfQuestions.length;
      Random rnd = new Random();
      int generatedIndex = min + rnd.nextInt(max - min);
      questions.add(selectedQUiz.listOfQuestions[generatedIndex]);
      print("$generatedIndex is in the range of $min and $max");
    }
  }

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController;
    _questionController = Get.put(QuestionController(currenUser));
    _questionController.setQuestionList(questions);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          actions: [
            FlatButton(
              onPressed: _questionController.nextQuestion,
              child: Text(
                "Preskoči pitanje",
                style: TextStyle(color: Color(0xff080947)),
              ),
            )
          ],
          backgroundColor: Color(0xff9dcbbc),
        ),
        body: SafeArea(
          child: PageView.builder(
              controller: _questionController.pageController,
              physics: NeverScrollableScrollPhysics(),
              allowImplicitScrolling: false,
              itemCount: _questionController.numOfQuestions,
              itemBuilder: (context, index) => QuestionWidget(
                    question: _questionController.questions[index],
                  )),
        ));
  }
}
