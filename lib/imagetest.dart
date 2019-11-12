/*import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';
import 'dart:io';
import 'dart:async';

class Uploads extends StatefulWidget {
  _UploadsState createState() => _UploadsState();
}

class _UploadsState extends State<Uploads> {
  final FirebaseStorage storage = FirebaseStorage(
      app: FirebaseStorage.instance.app,
      storageBucket: 'gs://breathe-ca4aa.appspot.com/');
  
  Uint8List imageBytes;
  String errorMsg;
  
  _UploadsState() {
   // _getImageUrl();
     storage
        .ref()
        .child('thumbsup.png')
        .getData(10000000)
        .then((data) => setState(() {
              imageBytes = data;
            }))
        .catchError((e) => setState(() {
              errorMsg = e.error;
            }));
  }
  
  @override
  Widget build(BuildContext context) {
   // _UploadsState();
    var img = imageBytes != null
        ? Image.memory(
            imageBytes,
            fit: BoxFit.cover,
          )
        : Text(errorMsg != null ? errorMsg : "Loading...");

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("what up"),
        ),
        body: new ListView(
          children: <Widget>[
            img,
          ],
        ));
  }


 /* Future _getImageUrl() async {
      final Future<StorageReference> ref =
          FirebaseStorage.instance.getReferenceFromUrl('gs://breathe-ca4aa.appspot.com/thumbsup.png');
      dynamic url = await ref.then((doc) => doc.getDownloadURL());
      print(url);
    }*/
}*/
