import 'package:flutter/material.dart';

class User {
  String name;
  String userName;
  String password;
  int numberOfPoints;

  User({
    @required this.name,
    @required this.userName,
    @required this.password,
    @required this.numberOfPoints
  }){

    // Ovdje se može staviti request koji će registrovati novog korinika ali u nekom drugom konstruktoru
    
  }
}