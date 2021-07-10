import 'package:flutter/material.dart';
import 'package:planinarska_obuka/main.dart';
import 'package:planinarska_obuka/models/content.dart';
import 'package:planinarska_obuka/models/content_list.dart';
import 'package:planinarska_obuka/models/user.dart';
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
      home: MainScreenPage(currentUser: currentUser,),
    );
  }
}

class MainScreenPage extends StatefulWidget {
  

  User currentUser;
  final String title;
  MainScreenPage({Key key, this.title, @required this.currentUser}) : super(key: key);

  @override
  _MainScreenPage createState() => _MainScreenPage(currentUser: currentUser);
}

class _MainScreenPage extends State<MainScreenPage> {
  // Ovaj dio zavisi od prijavljenog korisnika i requesta:
  User currentUser;
  _MainScreenPage({@required this.currentUser});

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
      requestURL: "_request_1_"
    ),
    Content(
      name: "Planinarska obuka",
      image: "assets/2.jpg",
      requestURL: "_request_2_"
    ),
    Content(
      name: "Rang lista igrača",
      image: "assets/3.jpg",
      requestURL: "_request_3_"
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
              UserProfileWidget(user: currentUser),
              ContentList(content)
              // Sadržaj početnog ekrana
            ],
          ),
        ),
      ),
    );
  }
}
