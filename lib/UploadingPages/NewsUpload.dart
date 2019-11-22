import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';

class NewsUpload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NewsUploadState();
}

class _NewsUploadState extends State<NewsUpload> {
  final formKey = new GlobalKey<FormState>();

  String _headline;
  String _newsFirm;
  String _websiteLink;
  String _timestamp = DateTime.now().toString().substring(0,19);
 

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
    databaseReference.child("News").push().set({
      'headline': this._headline,
      'newsFirm': this._newsFirm,
      'websiteLink': this._websiteLink,
      'timestamp': this._timestamp
    }
    );
    Fluttertoast.showToast(
          msg: (_headline + " uploaded"),
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
                  decoration: new InputDecoration(labelText: 'Headline'),
                  onSaved: (value) => _headline = value,
                  validator: (value) =>
                      value.isEmpty ? 'Headline cant be empty' : null),
                      new TextFormField(
                  decoration: new InputDecoration(labelText: 'News Firm'),
                  onSaved: (value) => _newsFirm = value,
                  validator: (value) =>
                      value.isEmpty ? 'News Firm cant be empty' : null),
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
