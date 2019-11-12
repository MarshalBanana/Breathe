import 'dart:ui' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:breathe/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:typed_data';

class PDF_list_item extends StatelessWidget {
  final String pdfTitle;
  final String subtitle;
  final String url;

  _launchURL() async {
    String url = this.url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  PDF_list_item(this.pdfTitle, this.subtitle, this.url);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lime[600],
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: ListTile(
          leading: Icon(Icons.assignment),
          title: Text(pdfTitle),
          subtitle: Text(subtitle),
          onTap: () {
            _launchURL();
          }),
    );
  }
}
