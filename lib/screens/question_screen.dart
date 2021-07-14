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
    this.selectedQUiz.listOfQuestions.forEach((element) {
      this.questions.add(element);

      // Ovdje implementirati odabir 10 random pitanja!!!!
      
    });
  }

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController;
    //_questionController.refresh();
    _questionController = Get.put(QuestionController(currenUser));
    _questionController.setQuestionList(selectedQUiz.listOfQuestions);
    //_questionController.refresh();

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
