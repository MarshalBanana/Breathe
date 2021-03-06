import 'dart:io';
import 'package:breathe/CoursesPageAdmin.dart';
import 'package:breathe/CoursesPageUser.dart';
import 'package:breathe/JobsPageAdmin.dart';
import 'package:breathe/NewsPageAdmin.dart';
import 'package:breathe/NewsPageUser.dart';
import 'package:breathe/RespaTherapy.dart';
import 'package:breathe/UserViewLearning.dart';
import 'package:breathe/signIn.dart';
import 'package:breathe/UploadingPages/videoUpload.dart';
import 'package:flutter/material.dart';
import 'package:breathe/tilegenerator.dart';
import 'package:breathe/aboutus.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:breathe/AdminViewLearning.dart';
import 'package:breathe/globals.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:breathe/signUp.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:async/async.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:breathe/Video_Page.dart';
import 'package:breathe/UploadingPages/pdfUpload.dart';
import 'package:breathe/UploadingPages/imageUpload.dart';
import 'package:breathe/JobsPage.dart';
import 'package:breathe/JobsPageUser.dart';

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
    String signup = AppLocalizations.of(context).tr('signup').toString();

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
                                builder: (context) => new SignUp()));
                      },
                      child: Container(
                        child: Text(signup),
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RespaTherapy()));
                      },
                      child: TileManager(whatsrespa, "assets/respatherapy.png"),
                    )),
                    Expanded(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  if (signed) {
                                    return NewsPageAdmin();
                                  } else {
                                    return NewsPageUser();
                                  }
                                }));
                              },
                              child: new TileManager(news, "assets/news.png"))),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          if (signed) {
                            return AdminViewLearning();
                          } else {
                            return UserViewLearning();
                          }
                        }));
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
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  if (signed) {
                                    return JobsPageAdmin();
                                  } else {
                                    return JobPageUser();
                                  }
                                }));
                              },
                              child: new TileManager(jobs, "assets/jobs.png"))),
                      Expanded(
                          child: GestureDetector(
                              onTap: () {},
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    if (signed) {
                                      return CoursesPageAdmin();
                                    } else {
                                      return CoursesPageUser();
                                    }
                                  }));
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
