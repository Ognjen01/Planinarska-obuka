import 'package:flutter/material.dart';
import 'package:planinarska_obuka/models/map.dart';
import 'package:photo_view/photo_view.dart';

class MapScreen extends StatelessWidget {
  Map map;
  MapScreen({@required this.map});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        iconTheme: IconThemeData(
          color: Color(0xff080947), //change your color here
        ),
        backgroundColor: Color(0xff9dcbbc),
        title: Text(
          map.name,
          style: TextStyle(color: Color(0xff080947), fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PhotoView(
          imageProvider: NetworkImage('${map.mapUrl}'),
          backgroundDecoration: BoxDecoration(color: Color(0xffffffff)),
        ),
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.download_sharp,
            color: Color(0xff080947),
          ),
          backgroundColor: Color(0xff9dcbbc),
          onPressed: () => {print("PREUZMANJE MAPE")
          }),
    );
  }
}
