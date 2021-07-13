import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planinarska_obuka/controllers/question_controller.dart';
import 'package:planinarska_obuka/models/question.dart';
import 'package:planinarska_obuka/models/quiz.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:planinarska_obuka/screens/main_screen.dart';
import 'package:planinarska_obuka/widgets/question_widget.dart';

class QuestionScreen extends StatelessWidget {
  User currenUser;
  Quiz selectedQUiz;
  List<Question> questions = [];

  QuestionScreen({@required this.currenUser, @required this.selectedQUiz}) {
    this.selectedQUiz.listOfQuestions.forEach((element) {
      this.questions.add(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController(selectedQUiz.listOfQuestions));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        
        actions: [
          FlatButton(
            onPressed: _questionController.nextQuestion,
            child: Text("Preskoči pitanje", style: TextStyle(color: Color(0xff080947)),),
          )
        ],
        backgroundColor: Color(0xff9dcbbc),
      ),
      body: SafeArea(child: Expanded
      (child: PageView.builder(
        controller: _questionController.pageController,
        physics: NeverScrollableScrollPhysics(),
        allowImplicitScrolling: false,
        itemCount: _questionController.questions.length,
        itemBuilder: (context, index ) => QuestionWidget(question: _questionController.questions[index],))),
    ));
  }
}


