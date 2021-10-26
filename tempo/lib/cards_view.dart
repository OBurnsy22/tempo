import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'google_auth.dart';


class cardsView extends StatefulWidget {
  final QueryDocumentSnapshot card_;

  cardsView({Key key, @required this.card_}) : super(key: key);

  @override
  cardsViewState createState() => cardsViewState();
}

class cardsViewState extends State<cardsView> {
  final rename_card_key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
            child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    title: const Text('Settings'),
                    onTap: () {

                    },
                  ),
                  ListTile(
                    title: const Text('Logout'),
                    onTap: () => googleAuth().googleSignOut(context),
                  )
                ]
            )
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                // container showing the card name
                Container(
                  child: GestureDetector(
                    onTap: changeCardNameForm,
                    child: Text(widget.card_.id)
                  )
                ),
                // OPTIONS MENU

              ],
            ),
          ]
        )
      )
    );
  }

  //form to rename a card
  Future<void> changeCardNameForm() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Rename Card"),
          content: Form(
              key: rename_card_key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: renameCardInput() + renameCardButtons(),
              )
          )
        );
      }
    );
  }

  //input for changeCardNameForm()
  List<Widget> renameCardInput() {
    return [
      TextFormField(
        key: Key("input_key"),
        onSaved: (String folderName) {
          //save here
          //_folder = folderName;
        },
        validator: (String newName) {
          //ensure a folder name was entered
          if ((newName.isEmpty)) {
            return 'Please enter text';
          }
          return null;
        },
      )
    ];
  }


  //buttons for changeCardNameForm()
  List<Widget> renameCardButtons() {
    return [
      Container(
          width: 250.0,
          height: 50.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              onPrimary: Color(0xFFE0F7FA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              side: BorderSide(
                width: 3,
                color: Colors.cyan.shade800,
              ),
            ),
            key: Key("submit_key"),
            onPressed: folderValidation,
            child: Text(
              "Create Folder",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          )),
    ];
  }

  //validates form for renaming a card
  bool folderValidation() {
    final form = rename_card_key.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        //update the cards name in firebase
        /*
        fb.fireDatabase().firebaseCreate(_folder, "f");
        data_retrieved = false;
        retrieveData();*/
      });
      return true;
    }
    return false;
  }



}