import 'dart:math';
import 'package:breathe/chewie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:video_player/video_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:breathe/PDF_list_item.dart';
import 'package:breathe/Video_Page.dart';
import 'package:breathe/PDF_Page.dart';
import 'package:breathe/Image_Page.dart';

class UserViewLearning extends StatefulWidget {
  _UserViewLearningState createState() => _UserViewLearningState();
}



/*class ImagePage extends StatelessWidget {

  Widget imageTile(String url) {
    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(20),
      width: 100,
      decoration: BoxDecoration(
          color: Colors.lime[600],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: FadeInImage.assetNetwork(
          placeholder: "assets/waitme.gif", image: url, fit: BoxFit.fill),
    );
  }
}*/
class _UserViewLearningState extends State<UserViewLearning> {
  int selected_page = 0;
  final pageOptions = [VideoPageNew(), PDFPageNew(), ImagePageNew()];
  @override
  
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
          data: data,
          child: Scaffold(
        
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lime[600],
          title: Text(AppLocalizations.of(context).tr('learning').toString()),
        ),
        body: pageOptions[selected_page],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.lime[600],
          selectedItemColor: Colors.white,
          currentIndex: selected_page,
          onTap: (int index) {
            setState(() {
              selected_page = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.video_library), title: Text("Videos")),
            BottomNavigationBarItem(icon: Icon(Icons.menu), title: Text("PDFs")),
            BottomNavigationBarItem(
                icon: Icon(Icons.image), title: Text("Images"))
          ],
        ),
      ),
    );
  }
}
