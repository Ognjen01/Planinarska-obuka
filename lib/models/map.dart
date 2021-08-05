import 'package:flutter/material.dart';

class Map{
  String name;
  String coverPhotoUrl;
  String mapUrl;
  String id;
  String gpxUrl;
  Map({
    @required this.coverPhotoUrl,
    @required this.mapUrl,
    @required this.name,
    @required this.id
  });
}