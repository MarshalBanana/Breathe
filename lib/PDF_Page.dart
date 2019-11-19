import 'package:chewie/chewie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:breathe/chewie_list_item.dart';
import 'package:video_player/video_player.dart';
import 'package:breathe/PDF_list_item.dart';

class PDFPageNew extends StatefulWidget {
  PDFPageNew({Key key}) : super(key: key);

  @override
  _PDFPageNewState createState() => _PDFPageNewState();
}

class _PDFPageNewState extends State<PDFPageNew> {
  static final databaseReference = FirebaseDatabase.instance.reference();
  Widget futureBuilder = new FutureBuilder(
    future: MakeCall().firebaseCalls(databaseReference), // async work
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return new Text('Press button to start');
        case ConnectionState.waiting:
          return Center(
            child: Column(
              children: <Widget>[
                new Text('Just a Sec...' ,style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
                Image.asset("assets/breathe.gif")
              ],
            ),
          );
        default:
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          else
            return ListView.builder(
              
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return PDF_list_item(snapshot.data[index].title ,snapshot.data[index].subtitle, snapshot.data[index].url);
              },
            );
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: futureBuilder,
    );
  }
}

class PDFDetailListItem {

  String subtitle;
  String title;
  String url;

  PDFDetailListItem(String title, String subtitle ,String url) {
    this.title = title;
    this.subtitle = subtitle;
    this.url = url;
  }
  factory PDFDetailListItem.fromJson(Map<dynamic, dynamic> parsedJson) {
    print(parsedJson['title'] + parsedJson['subtitle'] +parsedJson['url']);
    print(
        "****************************************************************************************************************************************************************8");

    return PDFDetailListItem(parsedJson['title'],parsedJson['subtitle'] ,parsedJson['url']);
  }
  
}

class PDFList {
  List<PDFDetailListItem> PdfList;

  PDFList({this.PdfList});

  static List<PDFDetailListItem> parsePDFs(PdfJSON) {
    List<PDFDetailListItem> vList = new List();
    print("PDFListmade");
    Iterable<dynamic> vlist = PdfJSON.values;
    print(vlist);

    vlist.forEach((value) {
      print(value);
      vList.add(PDFDetailListItem.fromJson(value));
    });
    print(vList);
    return vList;
  }

  factory PDFList.fromJSON(Map<dynamic, dynamic> json) {
    print("fromJSON called");
    return PDFList(PdfList: parsePDFs(json));
    //print(PDFList);
    //return PDFList(PDFList:  parsePDFs(json));
  }
}

class MakeCall {
  List<PDFDetailListItem> listItems = [];
  PDFList PdfList;
  Future<List<PDFDetailListItem>> firebaseCalls(
      DatabaseReference databaseReference) async {
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic, dynamic> jsonResponse = dataSnapshot.value["PDFs"];
    print("Makecall");
    PdfList = new PDFList.fromJSON(jsonResponse);
    //PDFList.PDFList.addAll(PDFList);
    print("PDFList made: " + PdfList.toString());
    listItems.addAll(PdfList.PdfList);
    print("added video info to items \n Make call done");

    return listItems;
  }
}
