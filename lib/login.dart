
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:firebase_database/firebase_database.dart';


class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  var signed = true;
  //FirebaseDatabase database = FirebaseDatabase.instance;
  

  
  void validateAndSave() {
    final form = formKey.currentState;
    //DatabaseReference myRef = database.reference();
    //var ref = myRef.child("messages");
    //ref.set("");

    form.save();
    if (form.validate()) {
      print("Form is valid. Email: $_email, password: $_password");
      authenticate();
      setState(() {
        signed = true;
      });
    } else {
      print("Form is invalid. Email: $_email, password: $_password");
    }
  }

  void authenticate() {
    if ((_email == "raghad.995@gmail.com" && _password == "12345678") ||
        (_email == "test123" && _password == "test123")) {
      signed = true;
      print("You have logged in");
      Fluttertoast.showToast(
        msg: "Logged in",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.limeAccent[500],
        textColor: Colors.black,
        fontSize: 16.0
    );
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.pop(context);
      signed = true;
      Navigator.pop(context);
      signed = true;
    } else {
      print("The user name or password is not correct");
      Fluttertoast.showToast(
        msg: "Your Credentials are not correct",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIos: 1,
        backgroundColor: Colors.limeAccent[500],
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
  }

  bool ifSigned() {
    return signed;
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
        title: new Text("Sign In to Breathe"),
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
                  decoration: new InputDecoration(labelText: 'Email'),
                  onSaved: (value) => _email = value,
                  validator: (value) =>
                      value.isEmpty ? 'Email cant be empty' : null),
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Password'),
                onSaved: (value) => _password = value,
                validator: (value) =>
                    value.isEmpty ? 'Password cant be empty' : null,
                obscureText: true,
              ),
              new RaisedButton(
                color: Colors.limeAccent[500],
                child: Text('Login', style: TextStyle(fontSize: 20.0)),
                onPressed: validateAndSave,
              )
            ],
          ),
        ),
      ),
    );
  }
}
