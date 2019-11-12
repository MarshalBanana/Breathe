import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("About Us"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: Center(
        child: Container(
          height: 500,
          width:  500,
          child: Text(
              "We are students of Respatory Therapy, and we are trying to make an app to accomodate to such students where they can find all the resources, information, and experiences to help them prosper in their field and also raise awarness about our relatively unknown career path. "),
        ),
      ),
    );
  }
}
