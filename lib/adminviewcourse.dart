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
import 'package:flutter/services.dart';
import 'package:breathe/Video_Page.dart';

class AdminViewLearning extends StatefulWidget {
  _AdminViewLearningState createState() => _AdminViewLearningState();
}

String Link1 =
    'https://firebasestorage.googleapis.com/v0/b/breathe-ca4aa.appspot.com/o/Packets.pdf?alt=media&token=31441e19-b178-4eb7-b416-32c5b01c125d';
String Link2 =
    'https://firebasestorage.googleapis.com/v0/b/breathe-ca4aa.appspot.com/o/1568099844108_%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D9%85%D9%84%D8%A7%D8%AA%20%D8%A7%D9%84%D9%85%D8%A7%D9%84%D9%8A%D8%A9%20%D8%A7%D9%84%D9%85%D8%B9%D8%A7%D8%B5%D8%B1%D8%A9%20151%20(1).pdf?alt=media&token=6d9ce5c1-9d07-44a2-8cb6-357ea31da7c7';
String ImageLink1 =
    "https://firebasestorage.googleapis.com/v0/b/breathe-ca4aa.appspot.com/o/thumbsdownjpg.jpg?alt=media&token=77b2041c-4544-4cb5-8c1d-e15f496bf2f3";
String ImageLink2 =
    "https://firebasestorage.googleapis.com/v0/b/breathe-ca4aa.appspot.com/o/learning%2FImages%2Fthumbsup.png?alt=media&token=3395290e-fa71-4c40-a5f3-fc5ad0d726bc";
String ImageLink3 =
    "https://www.yti.edu/shared/images/YTI-INFOGRAPHIC-respiratory-therapy.JPG";

class PDFPage extends StatelessWidget {
  //addUrl(Link2);
StorageReference storage = FirebaseStorage().ref().child("/learning/PDF");
StorageReference ref = FirebaseStorage().ref();
//List<String> strings = ref.
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        PDF_list_item(
            "Financial Transactions",
            "Descriptions of financial transactions in islam, Thsi is just stuff from my uni's course.Test stuff",
            Link2),
        PDF_list_item(
            "Networst Packets",
            "Again this is just stest stuff this is the first thing i saw on my desktop whle trying it ",
            Link1),
        PDF_list_item(
            "Financial Transactions",
            "Descriptions of financial transactions in islam, Thsi is just stuff from my uni's course.Test stuff",
            Link2),
        PDF_list_item(
            "Networst Packets",
            "Again this is just stest stuff this is the first thing i saw on my desktop whle trying it ",
            Link1),
        PDF_list_item(
            "Financial Transactions",
            "Descriptions of financial transactions in islam, Thsi is just stuff from my uni's course.Test stuff",
            Link2),
        PDF_list_item(
            "Networst Packets",
            "Again this is just stest stuff this is the first thing i saw on my desktop whle trying it ",
            Link1),
        PDF_list_item(
            "Financial Transactions",
            "Descriptions of financial transactions in islam, Thsi is just stuff from my uni's course.Test stuff",
            Link2),
        PDF_list_item(
            "Networst Packets",
            "Again this is just stest stuff this is the first thing i saw on my desktop whle trying it ",
            Link1)
      ],
    );
  }
}

class ImagePage extends StatelessWidget {

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

  //String ref = GetURLS();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        imageTile(ImageLink1),
        imageTile(ImageLink2),
        imageTile(ImageLink1),
        imageTile(ImageLink2),
        imageTile(ImageLink1),
        imageTile(ImageLink2),
        imageTile(ImageLink3)
      ],
    );
  }
}

/*class VideoPage extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return ListView(
      cacheExtent: 10000.00,
      children: <Widget>[
        new ChewieListItem(
            textforCard: "text",
          videoPlayerController: VideoPlayerController.network(
              "https://firebasestorage.googleapis.com/v0/b/breathe-ca4aa.appspot.com/o/Sample1.mp4?alt=media&token=432ee752-fa07-4a7d-8116-0b631d4cdeea"),
          //looping: true,
        ),
        new ChewieListItem(
          textforCard: "text",
          videoPlayerController: VideoPlayerController.network(
              "https://firebasestorage.googleapis.com/v0/b/breathe-ca4aa.appspot.com/o/Sample1.mp4?alt=media&token=432ee752-fa07-4a7d-8116-0b631d4cdeea"),
          //looping: true,
        ),
        new ChewieListItem(
            textforCard: "text",
          videoPlayerController: VideoPlayerController.network(
              "https://firebasestorage.googleapis.com/v0/b/breathe-ca4aa.appspot.com/o/Sample1.mp4?alt=media&token=432ee752-fa07-4a7d-8116-0b631d4cdeea"),
          //looping: true,
        ),
        new ChewieListItem(
          videoPlayerController: VideoPlayerController.network(
              "https://firebasestorage.googleapis.com/v0/b/breathe-ca4aa.appspot.com/o/Sample1.mp4?alt=media&token=432ee752-fa07-4a7d-8116-0b631d4cdeea"),
          //looping: true,
        )
      ],
    );
  }
}*/

class _AdminViewLearningState extends State<AdminViewLearning> {
  int selected_page = 0;
  final pageOptions = [VideoPageNew(), PDFPage(), ImagePage()];
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
