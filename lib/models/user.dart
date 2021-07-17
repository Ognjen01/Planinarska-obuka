import 'package:flutter/material.dart';

class User {
  String name;
  String userName;
  String password;
  int numberOfPoints;
  String id;

  User(
      {@required this.name,
      @required this.userName,
      @required this.password,
      @required this.numberOfPoints}) {
  }

  String getName() {
    return this.name;
  }

  String getUsername() {
    return this.userName;
  }

  int getNumOfPoints() {
    return this.numberOfPoints;
  }
}
