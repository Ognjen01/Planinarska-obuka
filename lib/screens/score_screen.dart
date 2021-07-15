import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planinarska_obuka/controllers/question_controller.dart';
import 'package:planinarska_obuka/models/question.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:planinarska_obuka/screens/all_quizzes_screen.dart';

class ScoreScreen extends StatelessWidget {
  User currentUser;
  ScoreScreen(this.currentUser);

  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController.empty());
    print("Score ekran inicijalizovan");
    int newPointsNumber =
        currentUser.numberOfPoints += _qnController.numOfCorrectAns;

    WidgetsBinding.instance.addPostFrameCallback((_) async => {
          await FirebaseFirestore.instance.collection('users')
            ..get().then((querySnapshot) {
              querySnapshot.docs.forEach((result) async {
                if ((currentUser.userName == result['userName']) &&
                    (currentUser.password == result['password'])) {
                  print("Nadjen je korisnik: ${result.data()}");

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc('${result.id}')
                      .update({'numberOfPoints': newPointsNumber});
                }
              });
            })
        });

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
                "${_qnController.numOfCorrectAns}/${_qnController.numOfQuestions}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Color(0xff080947)),
              ),
              Spacer(),
              SizedBox(
                width: 150.0,
                height: 50.0,
                child: new RaisedButton(
                  color: Color(0xff9dcbbc),
                  child: new Text(
                    'Nazad na obuke',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff080947)),
                  ),
                  onPressed: () {
                    _qnController.onClose();

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AllQUizzesScreen(currentUser)));
                  },
                ),
              ),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}
