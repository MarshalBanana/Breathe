import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:breathe/AdminViewLearning.dart';

class ImagePageNew extends StatefulWidget {
  ImagePageNew({Key key}) : super(key: key);

  @override
  _ImagePageNewState createState() => _ImagePageNewState();
}

class _ImagePageNewState extends State<ImagePageNew> {
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
                return Container(
                  padding: EdgeInsets.all(3),
                  margin: EdgeInsets.all(20),
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.lime[600],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: FadeInImage.assetNetwork(
                      placeholder: "assets/waitme.gif",
                      image: snapshot.data[index].url,
                      fit: BoxFit.fill),
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

class ImageDetailListItem {
  String url;

  ImageDetailListItem(String url) {
    this.url = url;
  }
  factory ImageDetailListItem.fromJson(Map<dynamic, dynamic> parsedJson) {
    print(parsedJson['url']);
    print(
        "****************************************************************************************************************************************************************8");

    return ImageDetailListItem(parsedJson['url']);
  }
}

class ImageList {
  List<ImageDetailListItem> imageList;

  ImageList({this.imageList});

  static List<ImageDetailListItem> parseImages(ImageJSON) {
    List<ImageDetailListItem> vList = new List();
    print("ImageListmade");
    Iterable<dynamic> vlist = ImageJSON.values;
    print(vlist);

    vlist.forEach((value) {
      print(value);
      vList.add(ImageDetailListItem.fromJson(value));
    });
    print(vList);
    return vList;
  }

  factory ImageList.fromJSON(Map<dynamic, dynamic> json) {
    print("fromJSON called");
    return ImageList(imageList: parseImages(json));
    //print(ImageList);
    //return ImageList(ImageList:  parseImages(json));
  }
}

class MakeCall {
  List<ImageDetailListItem> listItems = [];
  ImageList imageList;
  Future<List<ImageDetailListItem>> firebaseCalls(
      DatabaseReference databaseReference) async {
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic, dynamic> jsonResponse = dataSnapshot.value["Images"];
    print("Makecall");
    imageList = new ImageList.fromJSON(jsonResponse);
    //ImageList.ImageList.addAll(ImageList);
    print("ImageList made: " + imageList.toString());
    listItems.addAll(imageList.imageList);
    print("added image info to items \n Make call done");

    return listItems;
  }
}
