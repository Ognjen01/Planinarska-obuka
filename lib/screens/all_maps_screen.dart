import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planinarska_obuka/models/map.dart';
import 'package:planinarska_obuka/models/question.dart';
import 'package:planinarska_obuka/models/quiz.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:planinarska_obuka/screens/main_screen.dart';
import 'package:planinarska_obuka/widgets/map_widget.dart';
import 'package:planinarska_obuka/widgets/quiz_widget.dart';

class AllMapsScreen extends StatelessWidget {
  User currentUser;
  AllMapsScreen(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AllMapsPage(
        currentUser: currentUser,
      ),
    );
  }
}

class AllMapsPage extends StatefulWidget {
  User currentUser;

  AllMapsPage({@required this.currentUser});

  @override
  _AllMapsPage createState() => _AllMapsPage(currentUser: currentUser);
}

class _AllMapsPage extends State<AllMapsPage> {
  User currentUser;
  List<Map> allMaps = [];
  _AllMapsPage({@required this.currentUser});

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic result = await getMapsList();

    if (result == null) {
      print("Unable to retrive");
    } else {
      setState(() {
        allMaps = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xff080947)),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MainScreen(
                      currentUser: currentUser,
                    ))),
          ),
          title: Text(
            "Mape",
            style: TextStyle(
                color: Color(0xff080947), fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xff9dcbbc),
        ),
        body: ListView.builder(
          itemCount: allMaps.length,
          itemBuilder: (context, index) {
            print(allMaps[index].name);
            return MapWidget(allMaps[index], currentUser);
          },
        ));
  }

  Future getMapsList() async {
    List<Map> allMaps = [];
    try {
      await FirebaseFirestore.instance
          .collection("mape")
          .get()
          .then((querySnapshot) => {
                querySnapshot.docs.forEach((result) {
                  Map newMap = new Map(
                      coverPhotoUrl: result['coverPhotoUrl'],
                      mapUrl: result['mapUrl'],
                      name: result['name'],
                      id: result.id);
                      newMap.gpxUrl = result['gpxUrl'];

                  allMaps.add(newMap);
                })
              });
      return allMaps;
    } catch (e) {
      print(e.toString());
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Greška"),
                content: Text(
                    "Došlo je do greške, molimo pokušajte ponovo!"),
              ));
    }
  }
}
