import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';

class CourseUpload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CourseUploadState();
}

class _CourseUploadState extends State<CourseUpload> {
  final formKey = new GlobalKey<FormState>();

  String _courseTitle;
  String _courseDescription;
  String _websiteLink;
 

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
    databaseReference.child("Courses").push().set({
      'courseTitle': this._courseTitle,
      'courseDescription': this._courseDescription,
      'websiteLink': this._websiteLink
    }
    );
    Fluttertoast.showToast(
          msg: (_courseTitle + " uploaded"),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          backgroundColor: Colors.limeAccent[500],
          textColor: Colors.white,
          fontSize: 16.0);
    
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lime[500],
        title: new Text("Courses"),
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
                  decoration: new InputDecoration(labelText: 'Course Title'),
                  onSaved: (value) => _courseTitle = value,
                  validator: (value) =>
                      value.isEmpty ? 'Course Title cant be empty' : null),
                      new TextFormField(
                  decoration: new InputDecoration(labelText: 'Course Description'),
                  onSaved: (value) => _courseDescription = value,
                  validator: (value) =>
                      value.isEmpty ? 'Course Description cant be empty' : null),
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Website Link'),
                onSaved: (value) => _websiteLink = value,
                validator: (value) =>
                    value.isEmpty ? 'Website Link cant be empty' : null,
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
