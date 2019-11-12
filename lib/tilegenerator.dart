import 'dart:ui' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:breathe/main.dart';
import 'package:flutter/material.dart';

class TileManager extends StatelessWidget {
  final image_for_tile;
  final text_for_tile;

  TileManager(this.text_for_tile, this.image_for_tile);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipOval(
            child: Image.asset(
              image_for_tile,
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
          Text(text_for_tile, textAlign: prefix0.TextAlign.center,style: TextStyle(color: Colors.green[900],fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
