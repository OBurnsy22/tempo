import 'package:flutter/material.dart';

class timer extends StatefulWidget {
  @override
  timerState createState() => timerState();
}

class timerState extends State<timer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
        ),
      body: Center()
    );
  }
}