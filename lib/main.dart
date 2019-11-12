import 'dart:io';
import 'package:flutter/material.dart';
import 'package:breathe/imagetest.dart';
import 'package:breathe/tilegenerator.dart';
import 'package:breathe/aboutus.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:breathe/adminviewcourse.dart';
import 'package:breathe/globals.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:breathe/login.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:async/async.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

void main() {
  

SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(EasyLocalization(child: MyHome()));
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            canvasColor: Colors.lime[600],
            brightness: Brightness.light,
            primaryColor: Colors.lime[600]),
        routes: <String, WidgetBuilder>{
          'aboutus': (BuildContext context) => AboutUs(),
        },
        home: HomePage(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          EasylocaLizationDelegate(locale: data.locale, path: 'assets')
        ],
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'DZ')],
        locale: data.savedLocale,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter;
  //final FirebaseMessaging _messaging = FirebaseMessaging();
  @override
  Widget build(BuildContext context) {
    // this is for the localization of the tile strings we need to change the language of the tiles info when we change the language
    String jobs = AppLocalizations.of(context).tr('jobs').toString();
    String learning = AppLocalizations.of(context).tr('learning').toString();
    String whatsrespa =
        AppLocalizations.of(context).tr('whatsrespa').toString();
    String news = AppLocalizations.of(context).tr('news').toString();
    String aboutus = AppLocalizations.of(context).tr('aboutus').toString();
    String courses = AppLocalizations.of(context).tr('courses').toString();
    String login = AppLocalizations.of(context).tr('login').toString();

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
        data: data,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.limeAccent[500],
              title: Text(
                AppLocalizations.of(context).tr('title'),
                textAlign: TextAlign.center,
              ),
            ),
            drawer: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.

              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                      height: 80.0,
                      child: DrawerHeader(
                        child: Text('Breathe With Us'),
                        decoration: BoxDecoration(
                          color: Colors.limeAccent[500],
                        ),
                      )),
                  ListTile(
                    leading: Icon(Icons.supervised_user_circle),
                    title: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new LoginPage()));
                      },
                      child: Container(
                        child: Text(login),
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text('Change Language to Arabic'),
                    onTap: () {
                      setState(() {
                        data.changeLocale(Locale('ar', 'DZ'));
                        //Come here for the token for the firebase messaging
                        /*_messaging.getToken().then((token){
                          print(token);    
                        });*/
                      });

                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text('Change Language to English'),
                    onTap: () {
                      setState(() {
                        data.changeLocale(Locale('en', 'US'));
                      });

                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            body: Stack(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                    ),
              ),
              Column(
                children: <Widget>[
                  new Container(
                    
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/MainPagePic.jpeg"))),
                    height: 170,
                  ),
                  Container(
                    height: 50,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                      child: TileManager(
                        whatsrespa,
                        "assets/respatherapy.png",
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => new NewsPage()));
                            },
                            child: new TileManager(news, "assets/news.png"))),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new AdminViewLearning()));

                        /*else {
                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new ViewCourse()));

                      }*/
                      },
                      child: TileManager(learning, "assets/learning.png"),
                    ))
                  ]),
                  Container(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JobsPage()));
                              },
                              child: new TileManager(jobs, "assets/jobs.png"))),
                      Expanded(
                          child: GestureDetector(
                              onTap: () {},
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CoursesPage()));
                                },
                                child: new TileManager(
                                    courses, "assets/courses.png"),
                              ))),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutUs()));
                        },
                        child: TileManager(aboutus, "assets/aboutus.png"),
                      ))
                    ],
                  )
                ],
              ),
            ])));
  }
}

/*Future _getImageUrl() async {
      final Future<StorageReference> ref =
          FirebaseStorage.instance.getReferenceFromUrl('courses/thumbsup.png');
      dynamic url = await ref.then((doc) => doc.getDownloadURL());
      print(url);
    }*/

class AboutUs extends StatelessWidget {
  // var ref = FirebaseStorage.instance.ref().child('courses/thumbsup.png').getDownloadURL();
  // no need of the file extension, the name will do fine.
  //FirebaseStorage storage = FirebaseStorage.instance;
  //var ref = FirebaseStorage().ref();
  //var courses = ref.child('courses');
  //var url = _getImageUrl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.limeAccent[500],
            automaticallyImplyLeading: true,
            title: Text(AppLocalizations.of(context).tr('aboutus').toString()),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                height: 500,
                width: 500,
                child: Text(
                  AppLocalizations.of(context).tr('aboutusessay'),
                ),
              ),
              //Image.network(url.toString()),
            ],
          ),
        ));
  }
}

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.limeAccent[500],
            automaticallyImplyLeading: true,
            title: Text(AppLocalizations.of(context).tr('news').toString()),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            height: 500,
            width: 500,
            child: Text(
                "This is where I will put the news, it will be in the form of a list view where u can scrolldown and get the headlines and the date of posting for example."),
          ),
        ));
  }
}

class JobsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.limeAccent[500],
            automaticallyImplyLeading: true,
            title: Text(AppLocalizations.of(context).tr('jobs').toString()),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            height: 500,
            width: 500,
            child: Text(
                "This is where I will put the list of jobs, it will be in the form of a list view where you can scrolldown and get the job title and maybe a date with a snippet of the description before you tap on it and get taken to the page of the job with all the info."),
          ),
        ));
  }
}

class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.limeAccent[500],
            automaticallyImplyLeading: true,
            title: Text(AppLocalizations.of(context).tr('courses').toString()),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            height: 500,
            width: 500,
            child: Text(
                "This is where I will put the list of jobs, it will be in the form of a list view where you can scrolldown and get the course title and and outline of that course."),
          ),
        ));
  }
}
