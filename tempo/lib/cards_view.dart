import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'google_auth.dart';
import 'forms/cards_views_forms.dart';
import 'plate_calculator.dart';


class cardsView extends StatefulWidget {
  final QueryDocumentSnapshot card_;

  cardsView({Key key, @required this.card_}) : super(key: key);

  @override
  cardsViewState createState() => cardsViewState();
}

class cardsViewState extends State<cardsView> {
  final rename_card_key = GlobalKey<FormState>();
  final workout_rename_key = GlobalKey<FormState>();
  final set_count_rename = GlobalKey<FormState>();
  final change_weight_rename = GlobalKey<FormState>();
  Map<String, dynamic> workoutData;
  List workouts;
  List workoutsSetAndWeight;
  List<bool> checkboxStatus = [];
  String currentIdx;
  String updatedValue;

  @override
  void initState() {
    workoutData = widget.card_.data();
    for(int i=0; i<workoutData.length; i++) {
      checkboxStatus.add(false);
    }
    workouts = workoutData.keys.toList();
    workoutsSetAndWeight = workoutData.values.toList();
    super.initState();
  }

  void updateDataLists() {
    setState(() {
      workouts = workoutData.keys.toList();
      workoutsSetAndWeight = workoutData.values.toList();
    });
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
                width: MediaQuery.of(context).size.width * 0.90,
                //height: MediaQuery.of(context).size.height * 0.10,
                color: Colors.blue,
                child: Center(
                  child: GestureDetector(
                      onDoubleTap: changeCardNameForm,
                      child: Text(
                          widget.card_.id,
                        style: TextStyle(fontSize: 25),
                      )
                  )
                )
            ),
              Container(
                color: Colors.red,
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.80,
                child: ListView.builder(
                  itemCount: workoutData.length,
                  itemBuilder: (context, index){
                    print(workoutData);
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
                          onDoubleTap: () {
                            var idx = index.toString();
                            changeWorkoutName(idx);
                          },
                        ),
                        subtitle: GestureDetector(
                          child: Text(workoutsSetAndWeight[index][0]),
                          onDoubleTap: () {
                            var idx = index.toString();
                            print(idx);
                            changeSetCount(idx);
                          },
                        ),
                        trailing: GestureDetector(
                          child: Text(workoutsSetAndWeight[index][1] + "lbs"),
                          onDoubleTap: () {
                            var idx = index.toString();
                            print(idx);
                            changeWeight(idx);
                          },
                        ),
                      )
                    );
                  }
                ),
              ),
            Container(
              color: Colors.green,
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.08,
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  child: Icon(
                    Icons.calculate,
                    color: Colors.red,
                    size: 50.0,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => plateCalculator())
                    );
                  }
                )
              )
            )
          ]
        )
      )
    );
  }


  /**************** FORM FUNCTIONS FOR CHANGING WEIGHT ****************/

  //form to rename a card
  Future<void> changeWeight(String idx) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Change Weight"),
              content: Form(
                  key: change_weight_rename,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: changeWeightInput(idx) + changeWeightButtons(),
                  )
              )
          );
        }
    );
  }

//input for changeCardNameForm()
  List<Widget> changeWeightInput(String idx) {
    return [
      TextFormField(
        key: Key("input_key"),
        onSaved: (String weightInput) {
          //set the index so validation function can use it later
          currentIdx = idx;
          updatedValue = weightInput;
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
  List<Widget> changeWeightButtons() {
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
            onPressed: changeWeightValidation,
            child: Text(
              "Change Weight",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          )),
    ];
  }

  //validates form for renaming a card
  bool changeWeightValidation() {
    final form = change_weight_rename.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        //get the value array for this key
        var value_holder = workoutData[workouts[int.parse(currentIdx)]];

        //weights are in index 1 so change that value
        value_holder[1] = updatedValue;

        //update the key/value pair in the map
        workoutData[workouts[int.parse(currentIdx)]] = value_holder;

        //synchronize the lists
        updateDataLists();

        //UPDATE IN FIREBASE
      });
      return true;
    }
    return false;
  }


  /**************** FORM FUNCTIONS FOR SET COUNT ****************/

  //form to change set count
  Future<void> changeSetCount(String idx) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Change Set Count"),
              content: Form(
                  key: set_count_rename,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: changeSetCountInput(idx) + changeSetCountButtons(),
                  )
              )
          );
        }
    );
  }

//input for changeSetCount()
  List<Widget> changeSetCountInput(String idx) {
    return [
      TextFormField(
        key: Key("input_key"),
        onSaved: (String setCountName) {
          //set the index so validation function can use it later
          currentIdx = idx;
          updatedValue = setCountName;
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


//buttons for changeSetCounts()
  List<Widget> changeSetCountButtons() {
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
            onPressed: setCountRenameValidation,
            child: Text(
              "Change Set Count",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          )),
    ];
  }

  //changeSetCounts() validation
  bool setCountRenameValidation() {
    final form = set_count_rename.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        //get the value array for this key
        var value_holder = workoutData[workouts[int.parse(currentIdx)]];
        //sets are in 0 so change that value
        value_holder[0] = updatedValue;
        //update the key/value pair in the map
        workoutData[workouts[int.parse(currentIdx)]] = value_holder;
        //synchronize the lists
        updateDataLists();
        //UPDATE IN FIREBASE
      });
      return true;
    }
    return false;
  }



  /**************** FORM FUNCTIONS FOR CHANGING WORKOUT NAME ****************/

  //form to change workout name
  Future<void> changeWorkoutName(String idx) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Rename Workout"),
              content: Form(
                  key: workout_rename_key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: workoutNameInput(idx) + workoutNameButtons(),
                  )
              )
          );
        }
    );
  }

//input for changeWorkoutName()
  List<Widget> workoutNameInput(String idx) {
    return [
      TextFormField(
        key: Key("input_key"),
        onSaved: (String workoutName) {
          currentIdx = idx;
          updatedValue = workoutName;
          //set the index so validation function can use it later
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


//buttons for changeWorkoutName()
  List<Widget> workoutNameButtons() {
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
            onPressed: workoutNameValidation,
            child: Text(
              "Rename",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          )),
    ];
  }

  //changeWorkoutName() validation
  bool workoutNameValidation() {
    final form = workout_rename_key.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        //get the corresponding value to this key
        var value_holder = workoutData[workouts[int.parse(currentIdx)]];

        //delete the key/value from the map
        workoutData.remove(workouts[int.parse(currentIdx)]);

        //insert new pair back into the map
        workoutData[updatedValue] = value_holder;

        updateDataLists();

        //UPDATE IN FIREBASE
      });
      return true;
    }
    return false;
  }



  /**************** FORM FUNCTIONS FOR RENAMING A CARD ****************/

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
          //set the index so validation function can use it later
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




