import 'dart:io';

import 'package:flutter/material.dart';
import 'package:planinarska_obuka/models/map.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';

class MapScreen extends StatelessWidget {
  Map map;
  MapScreen({@required this.map});
  @override
  Widget build(BuildContext context) {
    FlutterDownloader.initialize();
    return Scaffold(
        appBar: AppBar(
          actions: [],
          iconTheme: IconThemeData(
            color: Color(0xff080947),
          ),
          backgroundColor: Color(0xff9dcbbc),
          title: Text(
            map.name,
            style: TextStyle(
                color: Color(0xff080947), fontWeight: FontWeight.bold),
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
                    onPressed: () async => {_requestDownload(map.gpxUrl)}),
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
        )

        /* FloatingActionButton(
          child: Icon(
            Icons.download_sharp,
            color: Color(0xff080947),
          ),
          backgroundColor: Color(0xff9dcbbc),
          onPressed: () async => {
                await ImageDownloader.downloadImage(map.mapUrl).catchError((e) {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text("Greška"),
                            content: Text(
                                "Došlo je do greške, molimo pokušajte ponovo!"),
                          ));
                }),
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Uspješno preuzeta fotografija")))
              }),
              */
        );
  }

  void _requestDownload(String link) async {
    Directory downloadsDirectory =
        await DownloadsPathProvider.downloadsDirectory;
    print(downloadsDirectory.toString());
    try {
      final taskId = await FlutterDownloader.enqueue(
        url: link,
        savedDir: downloadsDirectory.toString(),
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    } catch (e) {
      downloadsDirectory.create();
      print("Došlo je do greške: " + e.toString());
    }
  }
}
