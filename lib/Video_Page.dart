import 'package:chewie/chewie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:breathe/chewie_list_item.dart';
import 'package:video_player/video_player.dart';

class VideoPageNew extends StatefulWidget {
  VideoPageNew({Key key}) : super(key: key);

  @override
  _VideoPageNewState createState() => _VideoPageNewState();
}

class _VideoPageNewState extends State<VideoPageNew> {
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
              cacheExtent: 10000,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                                  child: Card(
                    color: Colors.white60,
                    child: Column(children: <Widget>[
                      Text(snapshot.data[index].title),
                      ChewieListItem(
                        videoPlayerController: VideoPlayerController.network(
                            snapshot.data[index].url),
                      ),
                    ]),
                  ),
                );
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

class VideoDetailListItem {
  VideoDetailListItem(String title, String url) {
    this.title = title;
    this.url = url;
  }
  factory VideoDetailListItem.fromJson(Map<dynamic, dynamic> parsedJson) {
    print(parsedJson['title'] + parsedJson['url']);
    print(
        "****************************************************************************************************************************************************************8");

    return VideoDetailListItem(parsedJson['title'], parsedJson['url']);
  }

  String title;
  String url;
}

class VideoList {
  List<VideoDetailListItem> videoList;

  VideoList({this.videoList});

  static List<VideoDetailListItem> parsevideos(videoJSON) {
    List<VideoDetailListItem> vList = new List();
    print("videoListmade");
    Iterable<dynamic> vlist = videoJSON["browseVideos"].values;
    print(vlist);

    vlist.forEach((value) {
      print(value);
      vList.add(VideoDetailListItem.fromJson(value));
    });
    print(vList);
    return vList;
  }

  factory VideoList.fromJSON(Map<dynamic, dynamic> json) {
    print("fromJSON called");
    return VideoList(videoList: parsevideos(json));
    //print(VideoList);
    //return VideoList(videoList:  parsevideos(json));
  }
}

class MakeCall {
  List<VideoDetailListItem> listItems = [];
  VideoList videoList;
  Future<List<VideoDetailListItem>> firebaseCalls(
      DatabaseReference databaseReference) async {
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic, dynamic> jsonResponse = dataSnapshot.value["Videos"];
    print("Makecall");
    videoList = new VideoList.fromJSON(jsonResponse);
    //videoList.videoList.addAll(videoList);
    print("videoList made: " + videoList.toString());
    listItems.addAll(videoList.videoList);
    print("added video info to items \n Make call done");

    return listItems;
  }
}
