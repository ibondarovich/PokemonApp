import 'dart:typed_data';

import 'package:flutter/material.dart';

class FullPictureWidget extends StatelessWidget{
  final Uint8List url;

  const FullPictureWidget({
    super.key,
    required this.url
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Image.memory(
            url,
            scale: 0.1,
          )
        ),
        onTap:() => Navigator.pop(context),
      )
    );
  }
}