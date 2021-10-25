import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase.dart' as fb;


class cardsView extends StatefulWidget {
  final QueryDocumentSnapshot card_;

  cardsView({Key key, @required this.card_}) : super(key: key);

  @override
  cardsViewState createState() => cardsViewState();
}

class cardsViewState extends State<cardsView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

      )
    );
  }
}