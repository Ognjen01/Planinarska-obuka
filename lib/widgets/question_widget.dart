import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planinarska_obuka/controllers/question_controller.dart';
import 'package:planinarska_obuka/models/question.dart';

import 'answer_widget.dart';

class QuestionWidget extends StatelessWidget {
  Question question;
  List<Question> questions;
  QuestionWidget({@required this.question, this.questions});
  // Formirati listu odgovora
  QuestionController _controller = Get.put(QuestionController.empty());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  "Slika",
                  style: TextStyle(
                      color: Color(0xffe9edf0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ), // Umjesto texta ide link do slike...
                width: double.infinity,
                height: 300.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xff080947),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ), // Slika
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  question
                      .question, // Dodati random broj koji odabira rendom pitanje .lenght obavezno
                  style: TextStyle(
                      color: Color(0xff080947),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                width: double.infinity,
                height: 100.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xffcadfdc),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ), // Pitanje
            Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0),
                child: Column(children: <Widget>[
                  // Potrebno je dinamičko učitavanje
                  ...List.generate(
                      question.answers.length,
                      (index) => AswerWidget(
                            index: index,
                            text: question.answers[index],
                            press: () => _controller.checkAns(question, index),
                          ))
                ])),
          ]),
        ),
      ),
    );
  }
}
