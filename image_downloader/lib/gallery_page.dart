import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_downloader/database.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Gallery'),
      ),
      body: FutureBuilder(
        future: DBProvider.db.retrieveFromDataBase(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, count) => Image.file(
                File(snapshot.data[count].imageUrl),
              ),
              itemCount: snapshot.data.length,
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
