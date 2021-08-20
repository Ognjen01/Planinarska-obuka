import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planinarska_obuka/models/map.dart';
import 'package:planinarska_obuka/models/quiz.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:planinarska_obuka/screens/map_screen.dart';
import 'package:planinarska_obuka/screens/question_screen.dart';
import 'package:bordered_text/bordered_text.dart';

class MapWidget extends StatelessWidget {
  Map map;
  User currentUser;

  MapWidget(this.map, this.currentUser);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            print("OVO TAP NA CONTAINER " + map.name);

            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MapScreen(map: map)));
          },
          child: Container(
            width: double.infinity,
            height: 200.0,
            child: Center(
              child: BorderedText(
                strokeWidth: 1.0,
                strokeColor: Colors.grey,
                child: Text("${map.name}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Color(0xffffffff))),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage('${map.coverPhotoUrl}'),
                    fit: BoxFit.cover)),
          ),
        ),
      ),
    );
  }
}
