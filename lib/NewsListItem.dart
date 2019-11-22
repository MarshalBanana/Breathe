import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsListItem extends StatelessWidget {
  final String headline;
  final String newsFirm;
  final String websiteLink;
  //final String timestamp = 
  final String timestamp ;
  NewsListItem(this.headline, this.newsFirm, this.websiteLink,this.timestamp);

  _launchURL() async {
    String url = this.websiteLink;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

/*Center(
          child: Container(
            padding: EdgeInsets.all(16),
            height: 500,
            width: 500,
            child: Text(
                "This is where I will put the list of jobs, it will be in the form of a list view where you can scrolldown and get the job title and maybe a date with a snippet of the description before you tap on it and get taken to the page of the job with all the info."),
          ),
        )*/

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        border: Border.all()
      ),
      padding: EdgeInsets.all(7.0),
      margin: EdgeInsets.all(7),
      child: ListTile(
          leading: Icon(Icons.library_books,color: Colors.green[900],),
          title: Text(headline),
          subtitle: Text(timestamp),
          contentPadding: EdgeInsets.all(5.0),
          trailing: Text(newsFirm),
          dense: true,
          onTap: () {
            _launchURL();
          }),
    );
  }
}
