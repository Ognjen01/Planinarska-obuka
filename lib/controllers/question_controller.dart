import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:planinarska_obuka/models/question.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:planinarska_obuka/screens/score_screen.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  AnimationController animationController;
  Animation animation;
  // so that we can access our animation outside
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

  // for more about obs please check documentation
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

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    print("CONTROLLER inicijalizacija");
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    animationController =
        AnimationController(duration: Duration(seconds: 90), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(() {
        // update like setState
        update();

      });

    // start our animation
    // Once 60s is completed go to the next qn
    animationController.forward().whenComplete(nextQuestion);
    pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    //animationController.dispose();
    //pageController.dispose();
    //super.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    print("CONTROLLER provjera odgovora");
    // because once user press any option then it will run
    isAnswered = true;
    correctAns = question.correctAnswerIndex;
    selectedAns = selectedIndex;

    if (correctAns == selectedAns) {
      numOfCorrectAns++;
      print("Tacan odgovor");
    }
    ;

    // It will stop the counter
    animationController.stop();
    update();

    // Once user select an ans after 1s it will go to the next qn
    Future.delayed(Duration(seconds: 1,), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    print("CONTROLLER sledeće pitanje");
    if (questionNumber.value != questions.length) {
      isAnswered = false;
      pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      animationController.forward().whenComplete(nextQuestion);
      updateTheQnNum(questionNumber.value);
    } else if (questionNumber.value == questions.length) {
      // Get package provide us simple way to naviigate another page
      //_pageController.dispose();
      //_animationController.dispose();
      //questions.removeRange(0, questions.length);
      print("Idemo na score screen");
      Get.to(() => ScoreScreen(currentUser));
    }
  }

  void updateTheQnNum(int index) {
    questionNumber.value = index + 1;
  }
}
