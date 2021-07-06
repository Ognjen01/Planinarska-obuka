import 'package:flutter/material.dart';
import 'package:planinarska_obuka/main.dart';
import 'package:planinarska_obuka/models/content.dart';
import 'package:planinarska_obuka/models/content_list.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:planinarska_obuka/widgets/user_profile_widget.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreenPage(),
    );
  }
}

class MainScreenPage extends StatefulWidget {
  MainScreenPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainScreenPage createState() => _MainScreenPage();
}

class _MainScreenPage extends State<MainScreenPage> {
  // Ovaj dio zavisi od prijavljenog korisnika i requesta:

  // TESTNI PODACI:

  User user1 = new User(
      name: "Ognjen",
      userName: "ognjen01",
      password: "ogara01",
      numberOfPoints: 10);

  List<Content> content = [
    Content(
      name: "Mape planinarskih staza",
      image: "assets/1.jpg",
      requestURL: "PRVI"
    ),
    Content(
      name: "Planinarska obuka",
      image: "assets/2.jpg",
      requestURL: "DRUGI"
    ),
    Content(
      name: "ELement 3",
      image: "assets/3.jpg",
      requestURL: "TRECI"
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff080947)),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MyApp())
                  // TODO: Provjeriti ovakvu implementanciju
                  ),
        ),
        title: Text(
          "Planinarska obuka",
          style:
              TextStyle(color: Color(0xff080947), fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff9dcbbc),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UserProfileWidget(user: user1),
              ContentList(content)
              // Sadržaj početnog ekrana
            ],
          ),
        ),
      ),
    );
  }
}
