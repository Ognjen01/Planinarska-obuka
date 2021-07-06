import 'package:flutter/material.dart';

class Registration extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
                "Registracija",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Spacer(flex: 1),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Ime i prezime',
                ),
              ),
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
                  child: new Text('Registruj se'),
                  onPressed: (){

                    // TODO: Request za Firebase bazu podataka i registrovanje novih korisnika,
                    //       Slanje na početni ekran, sa kvizovima mapama itd...

                    print("REGISTRACIJA");
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
