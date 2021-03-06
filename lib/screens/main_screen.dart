import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planinarska_obuka/main.dart';
import 'package:planinarska_obuka/models/content.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:planinarska_obuka/screens/all_maps_screen.dart';
import 'package:planinarska_obuka/screens/all_quizzes_screen.dart';
import 'package:planinarska_obuka/screens/users_rang_list.dart';
import 'package:planinarska_obuka/widgets/user_profile_widget.dart';

class MainScreen extends StatelessWidget {
  User currentUser;

  MainScreen({@required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreenPage(
        currentUser: currentUser,
      ),
    );
  }
}

class MainScreenPage extends StatefulWidget {
  User currentUser;
  final String title;
  MainScreenPage({Key key, this.title, @required this.currentUser})
      : super(key: key);

  @override
  _MainScreenPage createState() => _MainScreenPage(currentUser: currentUser);
}

class _MainScreenPage extends State<MainScreenPage> {
  User currentUser;
  _MainScreenPage({@required this.currentUser});

  // Test data
  User user1 = new User(
      name: "Ognjen",
      userName: "ognjen01",
      password: "ogara01",
      numberOfPoints: 10);

  List<Content> content = [
    Content(
        name: "Mape planinarskih staza",
        image: "assets/1.jpg",
        requestURL: "mape"),
    Content(name: "Obuka", image: "assets/2.jpg", requestURL: "quizzes"),
    Content(
        name: "Rang lista igrača", image: "assets/3.jpg", requestURL: "users")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Planinarska obuka",
          style: TextStyle(
            color: Color(0xff080947),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff9dcbbc),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  String text = " Tekst ";

                  FirebaseFirestore.instance.collection('sponsors')
                    ..get().then((querySnapshot) {
                      querySnapshot.docs.forEach((result) {
                        return text = result['text'];
                      });
                    }).then((value) => {
                          print("OVO JE TEKST : " + text),
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text("Informacije o aplikaciji"),
                              content: Text(text),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: Text("OK",
                                        style: TextStyle(
                                            color: Color(0xff080947))))
                              ],
                            ),
                          )
                        });
                },
                child: Icon(Icons.info_outline,
                    size: 26.0, color: Color(0xff080947)),
              )),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UserProfileWidget(user: currentUser),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AllMapsScreen(currentUser)));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 200.0,
                        child: Center(
                            child: Text("Mape planinarskih staza",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: AssetImage("assets/5.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AllQUizzesScreen(currentUser)));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 200.0,
                        child: Center(
                            child: Text("Obuka",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: AssetImage("assets/4.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserRangList(currentUser)));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 200.0,
                        child: Center(
                            child: Text("Rang lista takmičara",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: AssetImage("assets/17.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
