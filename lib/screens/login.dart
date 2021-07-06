import 'package:flutter/material.dart';
import 'package:planinarska_obuka/screens/main_screen.dart';
import 'package:planinarska_obuka/screens/registration.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xff080947)),
              ),
              Spacer(flex: 1),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Korisničko ime',
                ),
              ),
              TextField(
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
                  child: new Text('PRIJAVI SE',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff080947)),),
                  onPressed: () {

                    // TODO: Provjera konekcije

                    // TODO: Provjera da li postoji registrovani korisnika sa unesenim informacijama
                    //       Slanje na početni ekran

                    print("PRIJAVA");

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MainScreen()));
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
                child: new Text("Registruj se", style: TextStyle(color: Color(0xff080947)),),
              ),
              Spacer(flex: 6),
            ],
          ),
        ),
      ),
    );
  }
}


