import 'package:flutter/material.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main_screen.dart';

class Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegistrationPage(title: 'Planinarska obuka'),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController myController1 = new TextEditingController();
  TextEditingController myController2 = new TextEditingController();
  TextEditingController myController3 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/logo.png'),
              ),
              Text(
                "Registracija",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff080947)),
              ),
              Spacer(flex: 1),
              TextField(
                controller: myController1,
                decoration: InputDecoration(
                  labelText: 'Ime',
                ),
              ),
              TextField(
                controller: myController2,
                decoration: InputDecoration(
                  labelText: 'Korisničko ime',
                ),
              ),
              TextField(
                  controller: myController3,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Lozinka',
                  )),
              Spacer(flex: 1),
              SizedBox(
                width: 150.0,
                height: 50.0,
                child: new RaisedButton(
                  color: Color(0xff9dcbbc),
                  child: new Text(
                    'REGISTRUJ SE',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff080947)),
                  ),
                  onPressed: () async {
                    try {
                      bool userExist = false;

                      await FirebaseFirestore.instance.collection('users')
                        ..get().then((querySnapshot) {
                          querySnapshot.docs.forEach((result) {
                            print(result.data());

                            if (myController2.text == result['userName']) {
                              userExist = true;
                            }
                          });
                        }).then((value) => {
                              if (userExist)
                                {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: Text("Greška"),
                                            content: Text(
                                                "Već postoji korisnik sa istim korisničkim imenom"),
                                          ))
                                }
                              else if (!userExist)
                                {
                                  FirebaseFirestore.instance
                                    ..collection("users").add({
                                      "name": myController1.text,
                                      "numberOfPoints": 0,
                                      "userName": myController2.text,
                                      "password": myController3.text
                                    }).then((value) {
                                      print(value.id);
                                      AlertDialog(
                                          content: Text(
                                              "Uspješno izvršena registracija!"));

                                      User newUser = User(
                                          name: myController1.text,
                                          userName: myController2.text,
                                          password: myController3.text,
                                          numberOfPoints: 0);

                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => MainScreen(
                                                  currentUser: newUser)));
                                    })
                                }
                            });
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text("Greška"),
                                content: Text(
                                    "Došlo je do greške, molimo pokušajte ponovo!"),
                              ));
                    }
                  },
                ),
              ),
              Spacer(flex: 6),
            ],
          ),
        ),
      ),
    );
  }
}
