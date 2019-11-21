import 'package:chewie/chewie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:breathe/chewie_list_item.dart';
import 'package:video_player/video_player.dart';
import 'package:breathe/JobsListItem.dart';

class JobsPage extends StatefulWidget {
  JobsPage({Key key}) : super(key: key);

  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
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
                return JobsListItem(snapshot.data[index].jobTitle ,snapshot.data[index].company, snapshot.data[index].websiteLink);
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

class JobsDetailListItem {

  String jobTitle;
  String company;
  String websiteLink;

  JobsDetailListItem(String jobTitle, String company ,String websiteLink) {
    this.jobTitle = jobTitle;
    this.company = company;
    this.websiteLink = websiteLink;

  }
  factory JobsDetailListItem.fromJson(Map<dynamic, dynamic> parsedJson) {
    print(parsedJson['jobTitle'] + parsedJson['company'] +parsedJson['websiteLink']);
    print(
        "****************************************************************************************************************************************************************8");

    return JobsDetailListItem(parsedJson['jobTitle'],parsedJson['company'] ,parsedJson['websiteLink']);
  }
  
}

class JobsList {
  List<JobsDetailListItem> jobsList;

  JobsList({this.jobsList});

  static List<JobsDetailListItem> parseJobs(JobsJson) {
    List<JobsDetailListItem> vList = new List();
    print("JobsListmade");
    Iterable<dynamic> vlist = JobsJson.values;
    print(vlist);

    vlist.forEach((value) {
      print(value);
      vList.add(JobsDetailListItem.fromJson(value));
    });
    print(vList);
    return vList;
  }

  factory JobsList.fromJSON(Map<dynamic, dynamic> json) {
    print("fromJSON called");
    return JobsList(jobsList: parseJobs(json));
    //print(JobsList);
    //return JobsList(JobsList:  parseJobs(json));
  }
}

class MakeCall {
  List<JobsDetailListItem> listItems = [];
  JobsList jobsList;
  Future<List<JobsDetailListItem>> firebaseCalls(
      DatabaseReference databaseReference) async {
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic, dynamic> jsonResponse = dataSnapshot.value["Jobs"];
    print("Makecall");
    jobsList = new JobsList.fromJSON(jsonResponse);
    //JobsList.JobsList.addAll(JobsList);
    print("JobsList made: " + jobsList.toString());
    listItems.addAll(jobsList.jobsList);
    print("added job info to items \n Make call done");

    return listItems;
  }
}
