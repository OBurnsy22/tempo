import 'package:flutter/material.dart';


class analyticsHome extends StatefulWidget {

  @override
  analyticsHomeState createState() => analyticsHomeState();
}

class analyticsHomeState extends State<analyticsHome> with AutomaticKeepAliveClientMixin<analyticsHome>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("2")
          ],
        ),
      ),

    );
  }

  @override
  bool get wantKeepAlive => true;
}