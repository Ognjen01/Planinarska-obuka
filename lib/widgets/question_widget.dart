import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planinarska_obuka/controllers/question_controller.dart';
import 'package:planinarska_obuka/models/question.dart';

import 'answer_widget.dart';

class QuestionWidget extends StatelessWidget {
  Question question;
  List<Question> questions;
  QuestionWidget({@required this.question, this.questions});
  QuestionController _controller = Get.put(QuestionController.empty());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                width: double.infinity,
                height: 200.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        image: NetworkImage('${question.illustrationUrl}'),
                        fit: BoxFit.cover)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                
                child: Text(
                  question.question,
                  textAlign: TextAlign.center,
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
            ),
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0),
                  child: Column(children: <Widget>[
                    ...List.generate(
                        question.answers.length,
                        (index) => AswerWidget(
                            index: index,
                            text: question.answers[index],
                            press: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text("Objašenjenje",
                                            style: TextStyle(
                                                color: Color(0xff080947))),
                                        content: Text("${question.description}",
                                            style: TextStyle(
                                                color: Color(0xff080947))),
                                        actions: [
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                                _controller.checkAns(
                                                    question, index);
                                              },
                                              child: Text("OK",
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xff080947))))
                                        ],
                                      ),
                                  barrierDismissible: false);
                            }))
                  ])),
            ),
          ]),
        ),
      ),
    );
  }
}
