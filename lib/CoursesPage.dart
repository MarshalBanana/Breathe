import 'package:chewie/chewie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:breathe/chewie_list_item.dart';
import 'package:video_player/video_player.dart';
import 'package:breathe/CourseListItem.dart';

class CoursesPage extends StatefulWidget {
  CoursesPage({Key key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
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
                return CoursesListItem(snapshot.data[index].courseTitle ,snapshot.data[index].courseDescription, snapshot.data[index].websiteLink);
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

class CoursesDetailListItem {

  String courseTitle;
  String courseDescription;
  String websiteLink;

  CoursesDetailListItem(String courseTitle, String courseDescription ,String websiteLink) {
    this.courseTitle = courseTitle;
    this.courseDescription = courseDescription;
    this.websiteLink = websiteLink;

  }
  factory CoursesDetailListItem.fromJson(Map<dynamic, dynamic> parsedJson) {
    print(parsedJson['courseTitle'] + parsedJson['courseDescription'] +parsedJson['websiteLink']);
    print(
        "****************************************************************************************************************************************************************8");

    return CoursesDetailListItem(parsedJson['courseTitle'],parsedJson['courseDescription'] ,parsedJson['websiteLink']);
  }
  
}

class CoursesList {
  List<CoursesDetailListItem> coursesList;

  CoursesList({this.coursesList});

  static List<CoursesDetailListItem> parseCourses(CoursesJson) {
    List<CoursesDetailListItem> vList = new List();
    print("CoursesListmade");
    Iterable<dynamic> vlist = CoursesJson.values;
    print(vlist);

    vlist.forEach((value) {
      print(value);
      vList.add(CoursesDetailListItem.fromJson(value));
    });
    print(vList);
    return vList;
  }

  factory CoursesList.fromJSON(Map<dynamic, dynamic> json) {
    print("fromJSON called");
    return CoursesList(coursesList: parseCourses(json));
    //print(CoursesList);
    //return CoursesList(CoursesList:  parseCourses(json));
  }
}

class MakeCall {
  List<CoursesDetailListItem> listItems = [];
  CoursesList coursesList;
  Future<List<CoursesDetailListItem>> firebaseCalls(
      DatabaseReference databaseReference) async {
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic, dynamic> jsonResponse = dataSnapshot.value["Courses"];
    print("Makecall");
    coursesList = new CoursesList.fromJSON(jsonResponse);
    //CoursesList.CoursesList.addAll(CoursesList);
    print("CoursesList made: " + coursesList.toString());
    listItems.addAll(coursesList.coursesList);
    print("added job info to items \n Make call done");

    return listItems;
  }
}
