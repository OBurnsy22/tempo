import 'package:flutter/material.dart';


class searchHome extends StatefulWidget {

  @override
  searchHomeState createState() => searchHomeState();
}

class searchHomeState extends State<searchHome> with AutomaticKeepAliveClientMixin<searchHome> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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