import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';

class ImageUpload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  final formKey = new GlobalKey<FormState>();
  String _url;
  //FirebaseDatabase database = FirebaseDatabase.instance;

  final databaseReference = FirebaseDatabase.instance.reference();

  void validateAndSave() {
    final form = formKey.currentState;
    form.save();
  }

  void authenticate() {
      Fluttertoast.showToast(
          msg: "Record was Created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          backgroundColor: Colors.limeAccent[500],
          textColor: Colors.white,
          fontSize: 16.0);
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.pop(context); 
      Navigator.pop(context);
  }



  void createRecord() {
    validateAndSave();
    databaseReference.child("Images").push().set({
      'url': this._url
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lime[500],
        title: new Text("Upload Images"),
      ),
      body: new Container(
        padding: EdgeInsets.all(20),
        child: new Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 50,
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Url'),
                onSaved: (value) => _url = value,
                validator: (value) =>
                    value.isEmpty ? 'Url cant be empty' : null,
              ),
              new RaisedButton(
                color: Colors.limeAccent[500],
                child: Text('Upload', style: TextStyle(fontSize: 20.0)),
                onPressed: createRecord,
              )
            ],
          ),
        ),
      ),
    );
  }
}
