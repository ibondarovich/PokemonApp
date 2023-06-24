import 'package:flutter/material.dart';

class FullPictureWidget extends StatelessWidget{
  final String url;

  const FullPictureWidget({
    super.key,
    required this.url
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Image.network(
            url,
            scale: 0.1,
          )
        ),
        onTap:() => Navigator.pop(context),
      )
    );
  }
}