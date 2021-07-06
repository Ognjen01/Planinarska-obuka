import 'package:flutter/material.dart';
import 'package:planinarska_obuka/screens/registration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                  child: new Text('Prijavi se'),
                  onPressed: () {


                    // TODO: Provjera konekcije

                    // TODO: Provjera da li postoji registrovani korisnika sa unesenim informacijama
                    //       Slanje na početni ekran 
                    

                    print("PRIJAVA");
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
                child: new Text("Registruj se"),
              ),
              Spacer(flex: 6),
            ],
          ),
        ),
      ),
    );
  }
}