import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RespaTherapy extends StatelessWidget {

  TextStyle style = TextStyle(fontSize:18,color: Colors.green[900],fontWeight: FontWeight.w400);
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.limeAccent[500],
            automaticallyImplyLeading: true,
            title:
                Text(AppLocalizations.of(context).tr('whatsrespa').toString()),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Text(AppLocalizations.of(context).tr('respaessay').toString(),style: style),
        ),
      ),
    );
  }
}
