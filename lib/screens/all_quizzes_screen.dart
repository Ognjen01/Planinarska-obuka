import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planinarska_obuka/models/question.dart';
import 'package:planinarska_obuka/models/quiz.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:planinarska_obuka/screens/main_screen.dart';
import 'package:planinarska_obuka/widgets/quiz_widget.dart';

class AllQUizzesScreen extends StatelessWidget {
  User currentUser;
  AllQUizzesScreen(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AllQuizzesPage(
        currentUser: currentUser,
      ),
    );
  }
}

class AllQuizzesPage extends StatefulWidget {
  User currentUser;

  AllQuizzesPage({@required this.currentUser});

  @override
  _AllQUizzesPage createState() => _AllQUizzesPage(currentUser: currentUser);
}

class _AllQUizzesPage extends State<AllQuizzesPage> {
  User currentUser;
  List<Quiz> quizzes = [];
  _AllQUizzesPage({@required this.currentUser});

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic result = await getQuizList();

    if (result == null) {
      print("Unable to retrive");
    } else {
      setState(() {
        quizzes = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xff080947)),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MainScreen(
                      currentUser: currentUser,
                    ))),
          ),
          title: Text(
            "Obuke",
            style: TextStyle(
                color: Color(0xff080947), fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xff9dcbbc),
        ),
        body: ListView.builder(
          itemCount: quizzes.length,
          itemBuilder: (context, index) {
            print(quizzes[index].nameOfQuiz);
            return QuizWidget(quizzes[index], currentUser);
          },
        ));
  }

  Future getQuizList() async {
    List<Quiz> allQuizzes = [];
    try {
      await FirebaseFirestore.instance
          .collection("quizzes")
          .get()
          .then((querySnapshot) => {
                querySnapshot.docs.forEach((result) {
                  Quiz quiz = new Quiz(
                    nameOfQuiz: result['ime_kviza'],
                    coverPhotoUrl: result['slika'],
                  );
                  print("PrijeStatea");
                  setState(() {
                    FirebaseFirestore.instance
                        .collection("quizzes/${result.id}/pitanja")
                        .get()
                        .then((querySnapshotp) => {
                              querySnapshotp.docs.forEach((result1) {
                                Question newQuestion = new Question(
                                    question: result1['pitanje'],
                                    correctAnswer: result1['tacanOdgovor'],
                                    answer1: result1['odgovor1'],
                                    answer2: result1['odgovor2'],
                                    answer3: result1['odgovor3'],
                                    description: result1['objasnjenje']);
                                newQuestion.illustrationUrl =
                                    result1["illustrationUrl"];
                                print(result1["illustrationUrl"] +
                                    " SLika pitanja");
                                print("Drugi request unutra");
                                print(newQuestion.question);
                                quiz.listOfQuestions.add(newQuestion);
                              })
                            });
                  });
                  allQuizzes.add(quiz);
                })
              });
      return allQuizzes;
    } catch (e) {
      print(e.toString());
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Greška"),
                content: Text(
                    "Došlo je do greške, molimo pokušajte ponovo!"),
              ));
    }
  }

  Future getQuizQuestions(String quizId) async {
    List<Question> allQuestionsOfQuiz = [];
    try {
      await FirebaseFirestore.instance
          .collection("quizzes/${quizId}/pitanja")
          .get()
          .then((querySnapshotp) => {
                querySnapshotp.docs.forEach((result1) {
                  Question newQuestion = new Question(
                      question: result1['pitanje'],
                      correctAnswer: result1['tacanOdgovor'],
                      answer1: result1['odgovor1'],
                      answer2: result1['odgovor2'],
                      answer3: result1['odgovor3'],
                      description: result1['objasnjenje']);
                  print("Drugi request unutra");

                  allQuestionsOfQuiz.add(newQuestion);
                })
              });
      return allQuestionsOfQuiz;
    } catch (e) {
      print(e.toString());
      return (null);
    }
  }
}
