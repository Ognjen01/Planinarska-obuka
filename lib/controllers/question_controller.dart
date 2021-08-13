import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:planinarska_obuka/models/question.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:planinarska_obuka/screens/score_screen.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController animationController;
  Animation animation;
  Animation get animation1 => this.animation;

  PageController pageController;
  PageController get pageController1 => this.pageController;
  List<Question> questions = [];
  User currentUser;
  QuestionController(this.currentUser) {
    print("CONTROLLER inicijalizacija sa podacima");
  }
  QuestionController.empty() {
    print("CONTROLLER empty");
  }

  int numOfQuestions;

  bool isAnswered = false;
  bool get isAnswered1 => this.isAnswered;

  int correctAns;
  int get correctAns1 => this.correctAns;

  int selectedAns;
  int get selectedAns1 => this.selectedAns;

  RxInt questionNumber = 1.obs;
  RxInt get questionNumber1 => this.questionNumber;

  int numOfCorrectAns = 0;
  int get numOfCorrectAns1 => this.numOfCorrectAns;

  void setQuestionList(List<Question> list) {
    this.questions = list;
    pageController = new PageController();
    numOfCorrectAns = 0;
    questionNumber = 1.obs;
    isAnswered = false;
    numOfQuestions = list.length;
  }

  @override
  void onInit() {
    print("CONTROLLER inicijalizacija");

    animationController =
        AnimationController(duration: Duration(seconds: 300), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(() {
        update();
      });

    animationController.forward().whenComplete(nextQuestion);
    pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void checkAns(Question question, int selectedIndex) {
    print("CONTROLLER provjera odgovora");
    isAnswered = true;
    correctAns = question.correctAnswerIndex;
    selectedAns = selectedIndex;

    if (correctAns == selectedAns) {
      numOfCorrectAns++;
      print("Tacan odgovor");
    }
    ;

    animationController.stop();
    update();

    Future.delayed(
        Duration(
          seconds: 1,
        ), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    print("CONTROLLER sledeće pitanje");
    if (questionNumber.value != questions.length) {
      isAnswered = false;
      pageController.nextPage(
          duration: Duration(milliseconds: 350), curve: Curves.ease);

      animationController.reset();

      animationController.forward().whenComplete(nextQuestion);
      updateTheQnNum(questionNumber.value);
    } else if (questionNumber.value == questions.length) {
      print("Idemo na score screen");
      Get.to(() => ScoreScreen(currentUser));
    }
  }

  void updateTheQnNum(int index) {
    questionNumber.value = index + 1;
  }
}
