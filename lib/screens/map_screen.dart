import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:planinarska_obuka/models/map.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class MapScreen extends StatelessWidget {
  Map map;

  MapScreen({@required this.map});
  @override
  Widget build(BuildContext context) {
    FlutterDownloader.initialize();
    final externalDir = getExternalStorageDirectory();
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
                    onPressed: () async => {
                          print("Početak preuzimanja! "),
                          //await downloadFile(map.gpxUrl, map.name)
                          await FlutterDownloader.enqueue(url: map.gpxUrl, savedDir: externalDir.toString())
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
        ));
  }
    
    

  Future<String> downloadFile(String url, String fileName) async {
        HttpClient httpClient = new HttpClient();
        File file;
        String filePath = '';
        String myUrl = '';
        final dir = await getExternalStorageDirectory();
    
        try {
          myUrl = url+'/'+fileName;
          var request = await httpClient.getUrl(Uri.parse(myUrl));
          var response = await request.close();
          if(response.statusCode == 200) {
            var bytes = await consolidateHttpClientResponseBytes(response);
            filePath = '$dir/$fileName';
            file = File(filePath);
            await file.writeAsBytes(bytes);
          }
          else
            filePath = 'Error code: '+response.statusCode.toString();
        }
        catch(ex){
          filePath = 'Can not fetch url';
        }
    
        return filePath;
      }
}
