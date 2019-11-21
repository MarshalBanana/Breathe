
import 'package:breathe/CoursesPage.dart';
import 'package:breathe/UploadingPages/CourseUploadPage.dart';
import 'package:breathe/UploadingPages/JobsUpload.dart';
import 'package:breathe/UploadingPages/UploadLearning.dart';
import 'package:breathe/chewie_list_item.dart';
import 'package:breathe/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:easy_localization/easy_localization.dart';

class CoursesPageUser extends StatefulWidget {
  _CoursesPageUserState createState() => _CoursesPageUserState();
}

class _CoursesPageUserState extends State<CoursesPageUser> {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lime[600],
          title: Text(AppLocalizations.of(context).tr('courses').toString()),
          /*actions: <Widget>[
            IconButton(
              icon: Icon(Icons.cloud_upload),
              onPressed: () {},
            )
          ],*/
        ),
        body: CoursesPage()
          
        ),
      );
    
  }
}
