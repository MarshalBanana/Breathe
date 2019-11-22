
import 'package:breathe/NewsPage.dart';
import 'package:breathe/UploadingPages/NewsUpload.dart';
import 'package:breathe/main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


class NewsPageAdmin extends StatefulWidget {
  _NewsPageAdminState createState() => _NewsPageAdminState();
}

class _NewsPageAdminState extends State<NewsPageAdmin> {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewsUpload()));
            },
            child: Icon(Icons.add_circle),
            backgroundColor: Colors.green[900]),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lime[600],
          title: Text(AppLocalizations.of(context).tr('news').toString()),
          /*actions: <Widget>[
            IconButton(
              icon: Icon(Icons.cloud_upload),
              onPressed: () {},
            )
          ],*/
        ),
        body: NewsPage()
          
        ),
      );
    
  }
}
