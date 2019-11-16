import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


class AboutUs extends StatelessWidget {
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
                child: SelectableText(
                  AppLocalizations.of(context).tr('aboutusessay'),
                ),
              ),
              //Image.network(url.toString()),
            ],
          ),
        ));
  }
}