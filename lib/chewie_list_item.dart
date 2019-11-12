import 'package:breathe/globals.dart' as prefix0;
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:breathe/globals.dart';



class ChewieListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  //var coursesRef = storageRef.child('courses');
  //var storage = FirebaseStorage().ref();
  //var learningRef = prefix0.storageRef.child("learning").child("thumbsup.png");
  
  var textforCard;
  
  ChewieListItem({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    //wrapper on top of the videoPlayerController
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      autoInitialize: true,
      allowFullScreen: true, 
      aspectRatio: 16 / 9,
      
      //prepare the video to be played and display first frame
      
      looping: widget.looping,
      
      //Errors can occur for example when you try to play video from invalid URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //print(FirebaseStorage().ref().getPath());
    //print("****************************************************************************************************************************************************************8");
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white60,
        child: Column(
          children: <Widget>[
            Text("Title Text"),  
            Chewie(
              controller: _chewieController,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //important to dispose of used resources especially in video
    _chewieController.dispose();
    widget.videoPlayerController.dispose();
    super.dispose();
  }
}
