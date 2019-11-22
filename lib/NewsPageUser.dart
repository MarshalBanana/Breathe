
import 'package:breathe/NewsPage.dart';
import 'package:breathe/main.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


class NewsPageUser extends StatefulWidget {
  _NewsPageUserState createState() => _NewsPageUserState();
}

class _NewsPageUserState extends State<NewsPageUser> {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lime[600],
          title: Text(AppLocalizations.of(context).tr('news').toString()),
        ),
        body: NewsPage()
          
        ),
      );
    
  }
}
