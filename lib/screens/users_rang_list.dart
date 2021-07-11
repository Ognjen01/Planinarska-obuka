import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:planinarska_obuka/models/user_list.dart';
import 'package:planinarska_obuka/screens/main_screen.dart';

class UserRangList extends StatelessWidget {
  User currentUser;
  List<User> allUsers;
  UserRangList(this.allUsers, this.currentUser);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RangListPage(
        allUsers: allUsers,
        currentUser: currentUser,
      ),
    );
  }
}

class RangListPage extends StatefulWidget {
  User currentUser;
  List<User> allUsers;

  RangListPage({@required this.allUsers, @required this.currentUser});

  @override
  _RangListPage createState() =>
      _RangListPage(allUsers: allUsers, currentUser: currentUser);
}

class _RangListPage extends State<RangListPage> {
  User currentUser;
  List<User> allUsers;
  _RangListPage({@required this.allUsers, @required this.currentUser});

  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic result = await getUserList();

    if (result == null) {
      print("Unable to retrive");
    } else {
      setState(() {
        users = result;
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
                        ))
                // TODO: Provjeriti ovakvu implementanciju
                ),
          ),
          title: Text(
            "Rang lista takmičara",
            style: TextStyle(
                color: Color(0xff080947), fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xff9dcbbc),
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(users[index].name),
                subtitle: Text(users[index].userName),
              ),
            );
          },
        ));
  }

  // Async loading of users IMPORTANT!!!

  Future getUserList() async {
    List<User> allUsers = [];
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .get()
          .then((querySnapshot) => {
                querySnapshot.docs.forEach((result) {
                  User registredUser = new User(
                      name: result['name'],
                      numberOfPoints: result['numberOfPoints'],
                      password: result['password'],
                      userName: result['userName']);

                  allUsers.add(registredUser);
                })
              });
      return allUsers;
    } catch (e) {
      print(e.toString());
      return (null);
    }
  }
}
