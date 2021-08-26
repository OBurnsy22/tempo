import 'package:flutter/material.dart';
import 'main.dart';
import 'search.dart';

class searchHome extends StatefulWidget {

  @override
  searchHomeState createState() => searchHomeState();
}

class searchHomeState extends State<searchHome> with AutomaticKeepAliveClientMixin<searchHome> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("3")
          ],
        ),
      ),

    );
  }

  @override
  bool get wantKeepAlive => true;
}