import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:planinarska_obuka/models/map.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:flowder/flowder.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatelessWidget {
  Map map;

  MapScreen({@required this.map});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        iconTheme: IconThemeData(
          color: Color(0xff080947),
        ),
        backgroundColor: Color(0xff9dcbbc),
        title: Text(
          map.name,
          style:
              TextStyle(color: Color(0xff080947), fontWeight: FontWeight.bold),
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
      floatingActionButton: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 31),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                  heroTag: "btn1",
                  child: Text(
                    "gpx",
                    style: TextStyle(color: Color(0xff080947)),
                  ),
                  backgroundColor: Color(0xff9dcbbc),
                  onPressed: () async => {
                        print("Početak preuzimanja! "),
                        //await downloadFile(map.gpxUrl, map.name)
                        await downloadWithAnotherPackage(map, context)
                        // Preuzimanje gpx traga
                      }),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
                heroTag: "btn2",
                child: Icon(
                  Icons.download_sharp,
                  color: Color(0xff080947),
                ),
                backgroundColor: Color(0xff9dcbbc),
                onPressed: () async => {
                      await ImageDownloader.downloadImage(map.mapUrl)
                          .catchError((e) {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text("Greška"),
                                  content: Text(
                                      "Došlo je do greške, molimo pokušajte ponovo!"),
                                ));
                      }),
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Uspješno preuzeta fotografija")))
                    }),
          ),
        ],
      ),
    );
  }

  void downloadWithAnotherPackage(Map mapa, BuildContext context) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    String name = mapa.name;
    Directory path = await downloadsDirectory;

    Random rnd = new Random();
    int generatedIndex = 0 + rnd.nextInt(20 - 0);

    try {
      await File('${path.path}/$name.txt').create();
    } catch (e) {
      print("Fajl postoji");
    }

    final downloaderUtils = DownloaderUtils(
      progressCallback: (current, total) {
        final progress = (current / total) * 100;
        print('Downloading: $progress');
      },
      file: File('${path.path}/$name' + generatedIndex.toString() + '.kml'),
      progress: ProgressImplementation(),
      onDone: () => print('Download done'),
      deleteOnCancel: true,
    );

    final core = await Flowder.download(mapa.gpxUrl, downloaderUtils);
    //core.download(url, options)

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Uspješno preuzet gpx trag")));

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Objašenjenje", style: TextStyle(color: Color(0xff080947))),
        content: Text(
            "Uspješno ste preuzeli GPX trag planinara koji su već planinarili stazom ${mapa.name}. \n" +
                "GPX trag se nalazi u vašem Downloads folderu u fajlovima pod imenom ${mapa.name}${generatedIndex.toString()}.kml \n" +
                "Da bi ste otvorili ovaj fajl potrebno je da imate neku od aplikacija za prikaz .kml ili .gpx fajlova. \n" +
                "Ove aplikacije možete pronaći na Google Play Prodavnici",
            style: TextStyle(color: Color(0xff080947))),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text("OK", style: TextStyle(color: Color(0xff080947))))
        ],
      ),
    );
  }

  Future<Directory> downloadsDirectory =
      DownloadsPathProvider.downloadsDirectory;
}
