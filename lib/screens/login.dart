import 'package:flutter/material.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:planinarska_obuka/screens/main_screen.dart';
import 'package:planinarska_obuka/screens/registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController myController1 = new TextEditingController();
  TextEditingController myController2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Prijava",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff080947)),
              ),
              Spacer(flex: 1),
              TextField(
                controller: myController1,
                decoration: InputDecoration(
                  labelText: 'Korisničko ime',
                ),
              ),
              TextField(
                  controller: myController2,
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
                    'PRIJAVI SE',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff080947)),
                  ),
                  onPressed: () {
                    // TODO: Provjera konekcije

                    // TODO: Provjera da li postoji registrovani korisnika sa unesenim informacijama
                    //       Slanje na početni ekran

                    print("Pristupanje bazi pocinje");

                    try {

                      bool userExist = false;

                      FirebaseFirestore.instance.collection('users')
                        ..get().then((querySnapshot) {
                          querySnapshot.docs.forEach((result) {
                            print("===============================");
                            print(result.data());

                            if ((myController1.text == result['userName']) &&
                                (myController2.text == result['password'])) {
                              print("Nadjen je korisnik: ${result.data()}");
                              User currentUser = User(name: result['name'], numberOfPoints: result['numberOfPoints'], password: result['password'], userName: result['userName']);
                              Navigator.of(context).push(MaterialPageRoute(
                                  
                                  builder: (context) => MainScreen(currentUser: currentUser)));
                            }
                          }
                          );
                        });

                      if (!userExist) {
                        AlertDialog(
                          content: Text(
                              "Došlo je go greške, molimo pokušajte ponovo!"),
                        );
                      }
                    } catch (Exception) {
                      AlertDialog(
                        content: Text(
                            "Došlo je go greške, molimo pokušajte ponovo!"),
                      );
                    }

                    print("Pristupanje bazi završeno");
                  },
                ),
              ),
              Spacer(flex: 1),
              InkWell(
                onTap: () {
                  // TODO: Provjera konekcije

                  print("REGISTRACIJA");
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Registration()));
                },
                child: new Text(
                  "Registruj se",
                  style: TextStyle(color: Color(0xff080947)),
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
