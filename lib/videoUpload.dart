import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';

class VideoUpload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _VideoUploadState();
}

class _VideoUploadState extends State<VideoUpload> {
  final formKey = new GlobalKey<FormState>();

  String _title;
  String _url;
  //FirebaseDatabase database = FirebaseDatabase.instance;

  final databaseReference = FirebaseDatabase.instance.reference();

  void validateAndSave() {
    final form = formKey.currentState;
    //DatabaseReference myRef = database.reference();
    //var ref = myRef.child("messages");
    //ref.set("");

    form.save();
    /*if (form.validate()) {
      print("Form is valid. Email: $_email, name: $_name");
      authenticate();
      setState(() {
        signed = true;
      });
    } else {
      print("Form is invalid. Email: $_email, name: $_name");
    }*/
  }

  void authenticate() {
    //if ((_email == "raghad.995@gmail.com" && _password == "12345678") ||
      //  (_email == "test123" && _password == "test123")) {
      Fluttertoast.showToast(
          msg: "Record was Created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 2,
          backgroundColor: Colors.limeAccent[500],
          textColor: Colors.white,
          fontSize: 16.0);
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.pop(context); //signed = true;
      Navigator.pop(context);
    
    /*} else {
      print("The user name or password is not correct");
      Fluttertoast.showToast(
          msg: "Your Credentials are not correct",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 2,
          backgroundColor: Colors.limeAccent[500],
          textColor: Colors.white,
          fontSize: 16.0);
    }*/
  }



  void createRecord() {
    validateAndSave();
    databaseReference.child("Videos").child("browseVideos").push().set({
      'title': this._title,
      'url': this._url
    });
    
  }
  //for showing the pop up of invalid details when failure attempted login
  /*void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Invalid Login Details"),
            ));
  }*/

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lime[500],
        title: new Text("Upload Videos"),
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
                  decoration: new InputDecoration(labelText: 'Title'),
                  onSaved: (value) => _title = value,
                  validator: (value) =>
                      value.isEmpty ? 'Title cant be empty' : null),
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
