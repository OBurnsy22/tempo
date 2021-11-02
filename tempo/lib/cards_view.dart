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
  Map<String, dynamic> workoutData;
  List<bool> checkboxStatus = [];

  @override
  void initState() {
    workoutData = widget.card_.data();
    for(int i=0; i<workoutData.length; i++) {
      checkboxStatus.add(false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                color: Colors.red,
                child: GestureDetector(
                    onTap: changeCardNameForm,
                    child: Text(widget.card_.id)
                )
            ),
              Container(
                color: Colors.red,
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.90,
                child: ListView.builder(
                  /*
                    Index 0 is the set count, index 1
                    is the weight
                   */
                  itemCount: workoutData.length,
                  itemBuilder: (context, index){
                    List workouts = workoutData.keys.toList();
                    List workoutsSetAndWeight = workoutData.values.toList();
                    return Card(
                      child: ListTile(
                        leading: GestureDetector(
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Colors.blue,
                            ),
                            //make an array that each holds a bool value for the check status on each box
                            child: Checkbox(
                              activeColor: Colors.amberAccent,
                              checkColor: Colors.red,
                              value: checkboxStatus[index],
                              onChanged: (bool status) {
                                setState(() {
                                  checkboxStatus[index] = status;
                                });
                              }
                            )
                          ),
                        ),
                        title: GestureDetector(
                          child: Text(workouts[index]),
                        ),
                        subtitle: GestureDetector(
                          child: Text(workoutsSetAndWeight[index][0]),
                        ),
                        trailing: GestureDetector(
                          child: Text(workoutsSetAndWeight[index][1]),
                        ),
                      )
                    );
                  }
                ),
              )
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