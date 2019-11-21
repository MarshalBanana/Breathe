
import 'package:breathe/UploadingPages/JobsUpload.dart';
import 'package:breathe/UploadingPages/UploadLearning.dart';
import 'package:breathe/chewie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:easy_localization/easy_localization.dart';
import 'package:breathe/Video_Page.dart';
import 'package:breathe/PDF_Page.dart';
import 'package:breathe/Image_Page.dart';
import 'package:breathe/JobsPage.dart';

class JobsPageAdmin extends StatefulWidget {
  _JobsPageAdminState createState() => _JobsPageAdminState();
}

class _JobsPageAdminState extends State<JobsPageAdmin> {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => JobsUpload()));
            },
            child: Icon(Icons.add_circle),
            backgroundColor: Colors.green[900]),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lime[600],
          title: Text(AppLocalizations.of(context).tr('jobs').toString()),
          /*actions: <Widget>[
            IconButton(
              icon: Icon(Icons.cloud_upload),
              onPressed: () {},
            )
          ],*/
        ),
        body: JobsPage()
          
        ),
      );
    
  }
}
