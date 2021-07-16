import 'package:flutter/material.dart';

class Map{
  String name;
  String coverPhotoUrl;
  String mapUrl;
  String id;
  Map({
    @required this.coverPhotoUrl,
    @required this.mapUrl,
    @required this.name,
    @required this.id
  });
}