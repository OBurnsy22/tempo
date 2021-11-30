import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class analyticsHome extends StatefulWidget {

  @override
  analyticsHomeState createState() => analyticsHomeState();
}

class analyticsHomeState extends State<analyticsHome> with AutomaticKeepAliveClientMixin<analyticsHome>{
  //https://google.github.io/charts/flutter/gallery.html



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