import 'package:planinarska_obuka/models/content.dart';

import 'package:flutter/material.dart';
import 'package:planinarska_obuka/widgets/content_widget.dart';

class ContentList extends StatelessWidget {
  List<Content> list;

  ContentList(this.list);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
        children: list.map((con) {
          print(con.requestURL.toString());
          return Container(
            child: ContentWidget(con),
          );
        }).toList(),
      ),
    );
  }
}
