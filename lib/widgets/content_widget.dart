import 'package:flutter/material.dart';
import 'package:planinarska_obuka/models/content.dart';
import 'package:bordered_text/bordered_text.dart';

class ContentWidget extends StatelessWidget {
  Content content;

  ContentWidget(this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            print("PROBA");
            print("OVO TAP NA CONTAINER " + content.requestURL.toString());
          },
          child: Container(
            width: double.infinity,
            height: 200.0,
            child: Center(
                child: BorderedText(
                    strokeWidth: 1.0,
                    strokeColor: Colors.grey,
                    child: Text(content.name,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)))),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                    image: AssetImage(content.image), fit: BoxFit.cover)),
          ),
        ),
      ),
    );
  }
}
