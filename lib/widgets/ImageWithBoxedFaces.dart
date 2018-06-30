import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart' show Face;

class ImageWithBoxedFaces extends StatelessWidget {
  final File imageFile;
  final List<Face> facesInImage;

  const ImageWithBoxedFaces({
    Key key,
    @required this.imageFile,
    @required this.facesInImage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageFile == null) return Container();

    return Container(
      constraints: BoxConstraints.tightFor(),
      decoration: BoxDecoration(
        image: DecorationImage(
          // fit: BoxFit.fitHeight,
          image: FileImage(imageFile)
        )
      ),
      child: Stack(
        children: facesInImage.map<Widget>(
          (Face face) {
            Rectangle<int> r = face.boundingBox.boundingBox;
            return Positioned.fromRect(
              rect: Rect.fromLTWH(r.left.toDouble(), r.top.toDouble(), r.width.toDouble(), r.height.toDouble()),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 4.0)
                ),
              ),
            );
          }
        ).toList(growable: false)
      ),
    );
  }
}
