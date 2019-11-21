
import 'package:breathe/CoursesPage.dart';
import 'package:breathe/UploadingPages/CourseUploadPage.dart';
import 'package:breathe/UploadingPages/JobsUpload.dart';
import 'package:breathe/UploadingPages/UploadLearning.dart';
import 'package:breathe/chewie_list_item.dart';
import 'package:breathe/main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CoursesPageAdmin extends StatefulWidget {
  _CoursesPageAdminState createState() => _CoursesPageAdminState();
}

class _CoursesPageAdminState extends State<CoursesPageAdmin> {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CourseUpload()));
            },
            child: Icon(Icons.add_circle),
            backgroundColor: Colors.green[900]),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lime[600],
          title: Text(AppLocalizations.of(context).tr('courses').toString()),
        ),
        body: CoursesPage()
          
        ),
      );
    
  }
}
