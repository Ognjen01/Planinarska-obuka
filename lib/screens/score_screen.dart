import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planinarska_obuka/controllers/question_controller.dart';
import 'package:planinarska_obuka/models/question.dart';

class ScoreScreen extends StatelessWidget {

  List<Question> questions;
  ScoreScreen(this.questions);

  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController(questions));
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  Spacer(flex: 3),
                  Text(
                    "Broj bodova: ",
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: Color(0xff080947)),
                  ),
                  Spacer(),
                  Text(
                    "${_qnController.correctAns}/${_qnController.questions.length}",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Color(0xff080947)),
                  ),
                  Spacer(flex: 3),
                ],
              )
            ],
          ),
        );
      }
    
}
