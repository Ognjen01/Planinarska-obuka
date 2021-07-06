import 'package:flutter/material.dart';
import 'package:planinarska_obuka/main.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff080947) ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
                        builder: (context) => MyApp())
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
          padding: const EdgeInsets.all(60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Sadržaj početnog ekrana
            ],
          ),
        ),
      ),
    );
  }
}
