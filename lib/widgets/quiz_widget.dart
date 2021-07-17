import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planinarska_obuka/models/quiz.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:planinarska_obuka/screens/question_screen.dart';

class QuizWidget extends StatelessWidget {
  Quiz quiz;
  User currentUser;

  QuizWidget(this.quiz, this.currentUser);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            quiz.listOfQuestions.forEach((element) {
              print(element.description);
            });

            print("OVO TAP NA CONTAINER " + quiz.nameOfQuiz);

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QuestionScreen(
                      currenUser: currentUser,
                      selectedQUiz: quiz,
                    )));

            WidgetsBinding.instance
                .addPostFrameCallback((_) => Get.dialog(AlertDialog(
                      title: Text("Uputstvo"),
                      content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Kviz se sastoji od 10 pitanja."),
                            Text("Svako pitanje nosi po jedan bod."),
                            Text(
                                "Ne postoje negativni bodovi, niti oduzimanje postojećeg broja bodova."),
                            Text(
                              "Srećno!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            child: Text("OK",
                                style: TextStyle(color: Color(0xff080947))))
                      ],
                    )));
          },
          child: Container(
            width: double.infinity,
            height: 200.0,
            child: Center(
                child: Text(quiz.nameOfQuiz,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('${quiz.coverPhotoUrl}'),
                    fit: BoxFit.cover)),
          ),
        ),
      ),
    );
  }
}
