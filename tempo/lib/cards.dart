import 'package:flutter/material.dart';
import 'main.dart';
import 'search.dart';

class cardsHome extends StatefulWidget {

  @override
  cardsHomeState createState() => cardsHomeState();
}

class cardsHomeState extends State<cardsHome> with AutomaticKeepAliveClientMixin<cardsHome> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("1")
          ],
        ),
      ),

    );
  }

  @override
  bool get wantKeepAlive => true;
}