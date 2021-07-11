
import 'package:flutter/material.dart';
import 'package:planinarska_obuka/models/user.dart';
import 'package:planinarska_obuka/widgets/user_profile_widget.dart';

class UserList extends StatelessWidget {
  List<User> allUsers;

  UserList(this.allUsers);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
        children: allUsers.map((user) {
          return Container(
            child: UserProfileWidget(user: user),
          );
        }).toList(),
      ),
    );
  }
}
