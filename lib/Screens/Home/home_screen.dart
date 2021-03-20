import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/homeScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [IconButton(icon: Icon(Icons.add), onPressed: onPressed)],
      ),
      body: Container(),
    );
  }
}
