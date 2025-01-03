import 'package:flutter/material.dart';
import 'package:main_view/src/ui/main_view_content.dart';

class MainViewScreen extends StatelessWidget {
  const MainViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.grey,
        primaryColor: Colors.grey[50],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Pokemon tracker",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: MainViewContent(),
      ),
    );
  }
}
