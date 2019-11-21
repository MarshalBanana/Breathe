
import 'package:breathe/UploadingPages/UploadLearning.dart';
import 'package:breathe/chewie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:easy_localization/easy_localization.dart';
import 'package:breathe/Video_Page.dart';
import 'package:breathe/PDF_Page.dart';
import 'package:breathe/Image_Page.dart';

class AdminViewLearning extends StatefulWidget {
  _AdminViewLearningState createState() => _AdminViewLearningState();
}

class _AdminViewLearningState extends State<AdminViewLearning> {
  int selected_page = 0;
  final pageOptions = [VideoPageNew(), PDFPageNew(), ImagePageNew()];
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UploadLearning()));
            },
            child: Icon(Icons.add_circle),
            backgroundColor: Colors.green[900]),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lime[600],
          title: Text(AppLocalizations.of(context).tr('learning').toString()),
          /*actions: <Widget>[
            IconButton(
              icon: Icon(Icons.cloud_upload),
              onPressed: () {},
            )
          ],*/
        ),
        body: pageOptions[selected_page],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.lime[600],
          selectedItemColor: Colors.white,
          currentIndex: selected_page,
          onTap: (int index) {
            setState(() {
              selected_page = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.video_library), title: Text("Videos")),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu), title: Text("PDFs")),
            BottomNavigationBarItem(
                icon: Icon(Icons.image), title: Text("Images"))
          ],
        ),
      ),
    );
  }
}
