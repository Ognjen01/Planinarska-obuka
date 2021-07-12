import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:planinarska_obuka/models/user_list.dart';
import 'package:planinarska_obuka/screens/main_screen.dart';
import 'package:planinarska_obuka/widgets/user_profile_widget.dart';

class UserRangList extends StatelessWidget {
  User currentUser;
  UserRangList(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RangListPage(
        currentUser: currentUser,
      ),
    );
  }
}

class RangListPage extends StatefulWidget {
  User currentUser;

  RangListPage({@required this.currentUser});

  @override
  _RangListPage createState() =>
      _RangListPage(currentUser: currentUser);
}

class _RangListPage extends State<RangListPage> {
  User currentUser;
  List<User> users = [];
  _RangListPage({@required this.currentUser});


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
    bubbleSort(users);
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
            "Rang lista takmičara",
            style: TextStyle(
                color: Color(0xff080947), fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xff9dcbbc),
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return UserProfileWidget(user: users[index]);
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

  // Sorting algoryhm for user rang list: 
  List<User> bubbleSort(List<User> list) {
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < list.length - 1; j++) {
        if (list[j].numberOfPoints < list[j + 1].numberOfPoints) {
          User num = list[j];
          list[j] = list[j + 1];
          list[j + 1] = num;
        }
      }
    }
    return list;
  }
}
