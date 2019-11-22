import 'package:chewie/chewie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:breathe/chewie_list_item.dart';
import 'package:video_player/video_player.dart';
import 'package:breathe/NewsListItem.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
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
                return NewsListItem(snapshot.data[index].headline ,snapshot.data[index].newsFirm, snapshot.data[index].websiteLink,snapshot.data[index].timestamp);
              },
            );
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return  futureBuilder;
    
  }
}

class NewsDetailListItem {

  String headline;
  String newsFirm;
  String websiteLink;
  String timestamp;

  NewsDetailListItem(String headline, String newsFirm ,String websiteLink,String timestamp) {
    this.headline = headline;
    this.newsFirm = newsFirm;
    this.websiteLink = websiteLink;
    this.timestamp = timestamp;

  }
  factory NewsDetailListItem.fromJson(Map<dynamic, dynamic> parsedJson) {
    print(parsedJson['headline'] + parsedJson['newsFirm'] +parsedJson['websiteLink']+parsedJson['timestamp']);
    print(
        "****************************************************************************************************************************************************************8");

    return NewsDetailListItem(parsedJson['headline'],parsedJson['newsFirm'] ,parsedJson['websiteLink'],parsedJson['timestamp']);
  }
  
}

class NewsList {
  List<NewsDetailListItem> newsList;

  NewsList({this.newsList});

  static List<NewsDetailListItem> parseNews(NewsJson) {
    List<NewsDetailListItem> vList = new List();
    print("NewsListmade");
    Iterable<dynamic> vlist = NewsJson.values;
    print(vlist);

    vlist.forEach((value) {
      print("sasasa");
      print(value);
      vList.add(NewsDetailListItem.fromJson(value));
    });
    ;
    print(vList);
    
    return vList;
  }

  factory NewsList.fromJSON(Map<dynamic, dynamic> json) {
    print("fromJSON called");
    return NewsList(newsList: parseNews(json));
    //print(NewsList);
    //return NewsList(NewsList:  parseNews(json));
  }
}

class MakeCall {
  List<NewsDetailListItem> listItems = [];
  NewsList newsList;
  Future<List<NewsDetailListItem>> firebaseCalls(
      DatabaseReference databaseReference) async {
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic, dynamic> jsonResponse = dataSnapshot.value["News"];
    print("Makecall");
    newsList = new NewsList.fromJSON(jsonResponse);
    print("www");
    //NewsList.NewsList.addAll(NewsList);
    print("NewsList made: " + newsList.toString());
    listItems.addAll(newsList.newsList);
    print("added news info to items \n Make call done");

    return listItems;
  }
}
