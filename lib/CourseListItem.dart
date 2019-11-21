import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class CoursesListItem extends StatelessWidget {
  final String courseTitle;
  final String courseDescription;
  final String websiteLink;

  CoursesListItem(this.courseTitle, this.courseDescription, this.websiteLink);

  _launchURL() async {
    String url = this.websiteLink;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
          leading: Icon(Icons.business_center,color: Colors.green[900],),
          title: Text(courseTitle),
          subtitle: Text(courseDescription),
          onTap: () {
            _launchURL();
          }),
    );
  }
}
