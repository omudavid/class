import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/database.dart';
import 'package:image_downloader/gallery_page.dart';
import 'package:image_downloader/image_dao.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();
  String? url;
  String? fileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Image Downloader'),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (val) {
                  if (val?.isEmpty ?? true) {
                    return 'Please Put a url';
                  }
                },
                onSaved: (val) {
                  setState(() {
                    url = val!;
                  });
                },
              ),
              Expanded(child: Builder(builder: (context) {
                if (fileName == null) {
                  return Center(
                      child: Text('Downloaded Image Will Appear here'));
                }
                return Image.file(
                  File(fileName!),
                );
              })),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              downloadImage();
                            }
                          },
                          child: Text('Download Image'))),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              fileName = null;
                              url = null;
                              formKey.currentState?.reset();
                            });
                          },
                          child: Text('Reset'))),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GalleryPage()));
                          },
                          child: Text('Go to Gallery'))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> downloadImage() async {
    ///Get the document directory
    final dir = await getApplicationDocumentsDirectory();

    ///How many are in the database
    final number = (await DBProvider.db.retrieveFromDataBase()).length + 1;

    final dio = Dio();

    await dio.download(url!, '${dir.path}/$number.png',
        onReceiveProgress: (int dp, int fs) {
      if (dp == fs) {
        setState(() {
          fileName = '${dir.path}/$number.png';
        });
      }
    });

    await DBProvider.db.addToDataBase(
        ImageDao(id: number, imageUrl: '${dir.path}/$number.png'));
  }
}
