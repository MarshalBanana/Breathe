import 'package:breathe/UploadingPages/imageUpload.dart';
import 'package:breathe/UploadingPages/pdfUpload.dart';
import 'package:breathe/UploadingPages/videoUpload.dart';
import 'package:flutter/material.dart';

class UploadLearning extends StatelessWidget {
  const UploadLearning({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Material"),
        backgroundColor: Colors.lime[500],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(120, 180, 0, 0),
        child: Column(
          children: <Widget>[
            RaisedButton(
               color: Colors.lime[500],
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VideoUpload()));
              },
              child: Text("Add a Video"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20,bottom: 20),
              child: RaisedButton(
                color: Colors.lime[500],
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PDFUpload()));
                },
                child: Text("Add a PDF File"),
              ),
            ),
            RaisedButton(
               color: Colors.lime[500],
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ImageUpload()));
              },
              child: Text("Add an Image"),
            )
          ],
        ),
      ),
    );
  }
}
