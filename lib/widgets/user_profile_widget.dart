import 'package:flutter/material.dart';
import 'package:planinarska_obuka/models/user.dart';

class UserProfileWidget extends StatefulWidget {
  User user;

  UserProfileWidget({@required this.user});

  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState(user);
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  User user;

  _UserProfileWidgetState(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Card(
          shadowColor: Color(0xff9dcbbc),
          color: Color(0xffcadfdc),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Ime:",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: Color(0xff080947))),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          user.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xff080947)),
                        ),
                      ),
                      Text("Korisničko ime:",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: Color(0xff080947))),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(user.userName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xff080947))),
                      ),
                    ]),
                Spacer(flex: 6),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text("Broj poena:",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Color(0xff080947))),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        user.numberOfPoints.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 70,
                            color: Color(0xff080947)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
