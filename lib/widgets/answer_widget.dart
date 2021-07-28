import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:planinarska_obuka/controllers/question_controller.dart';

class AswerWidget extends StatelessWidget {
  const AswerWidget({
    Key key,
    this.text,
    this.index,
    this.press,
  }) : super(key: key);
  final String text;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GetBuilder<QuestionController>(
            init: QuestionController.empty(),
            builder: (qnController) {
              Color getTheRightColor() {
                if (qnController.isAnswered) {
                  if (index == qnController.correctAns) {
                    return Color(0xff9dcbbc);
                  } else if (index == qnController.selectedAns &&
                      qnController.selectedAns != qnController.correctAns) {
                    return Colors.red[100];
                  }
                }
                return Color(0xffcadfdc);
              }

              return InkWell(
                onTap: press,
                child: Container(
                  child: Text(
                    text,
                    style: TextStyle(
                        color: Color(0xff080947),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  width: double.infinity,
                  height: 50.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: getTheRightColor(),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              );
            }),
      ),
    );
  }
}
