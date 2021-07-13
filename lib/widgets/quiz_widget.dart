import 'package:flutter/material.dart';
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
              onTap: (){
                
                quiz.listOfQuestions.forEach((element) {
                  print(element.description);
                });
                
                print("OVO TAP NA CONTAINER " + quiz.nameOfQuiz);

                // Here I will put connection with the starting of the quiz...

                Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => QuestionScreen(currenUser: currentUser, selectedQUiz: quiz,)));


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
                    //color: Colors.indigo,
                    image: DecorationImage(
                        image: NetworkImage('${quiz.coverPhotoUrl}'), fit: BoxFit.cover)),
              ),
            ),
          ),
        );
  }
}
