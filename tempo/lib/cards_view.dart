import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'google_auth.dart';
import 'forms/cards_views_forms.dart';
import 'plate_calculator.dart';
import 'firebase.dart';
import 'timer.dart';

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
  final add_workout_form = GlobalKey<FormState>();

  Map<String, dynamic> workoutData;
  List workouts;
  List workoutsSetAndWeight;
  List<bool> checkboxStatus = [];
  String currentIdx;
  String updatedValue;

  String newWorkoutName;
  String newWorkoutSetCount;
  String newWorkoutWeight;
  String newCardName;

  String currentCardName;

  bool newDocument = false;

  @override
  void initState() {
    workoutData = widget.card_.data();
    updateDataLists();
    currentCardName = widget.card_.id.substring(2, widget.card_.id.length - 5);
    super.initState();
  }

  void updateDataLists() {
    setState(() {
      for (int i = 0; i < workoutData.length; i++) {
        checkboxStatus.add(false);
      }
      workouts = workoutData.keys.toList();
      workoutsSetAndWeight = workoutData.values.toList();
    });
  }

  void navigateBack() async {
    if (!newDocument) {
      fireDatabase().updateCollection(workoutData, widget.card_.id);
    } else {
      fireDatabase().updateAndRenameCollection(
          workoutData, widget.card_.id, currentCardName);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade700,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 40,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: navigateBack,
            child: Icon(Icons.arrow_back, color: Colors.deepOrange[300]),
          ),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      //height: MediaQuery.of(context).size.height * 0.10,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.deepOrange[300],
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                        onDoubleTap: changeCardNameForm,
                                        child: Text(
                                          currentCardName,
                                          style: TextStyle(fontSize: 25),
                                        )))),
                            Spacer(),
                            Container(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                        onTap: addWorkoutForm,
                                        child: Icon(
                                          Icons.add_outlined,
                                          size: 40,
                                        )))),
                          ])),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.78,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.deepOrange[300],
                    ),
                    child: ListView.builder(
                        itemCount: workoutData.length,
                        itemBuilder: (context, index) {
                          print(workoutData);
                          return Card(
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(2))),
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
                                              })),
                                    ),
                                    title: GestureDetector(
                                      child: Text(workouts[index]),
                                      onDoubleTap: () {
                                        var idx = index.toString();
                                        changeWorkoutName(idx);
                                      },
                                    ),
                                    subtitle: GestureDetector(
                                      child: Text(
                                          workoutsSetAndWeight[index][0].trim() == "" ? "*Set Count*" : workoutsSetAndWeight[index][0].trim()
                                      ),
                                      onDoubleTap: () {
                                        var idx = index.toString();
                                        print(idx);
                                        changeSetCount(idx);
                                      },
                                    ),
                                    trailing: GestureDetector(
                                      child: Text(
                                          workoutsSetAndWeight[index][workoutsSetAndWeight[index].length-1] == null
                                              ? "*Weight*"
                                              : workoutsSetAndWeight[index][workoutsSetAndWeight[index].length-1].trim().split(" ")[0]
                                      ),
                                      onDoubleTap: () {
                                        var idx = index.toString();
                                        print(idx);
                                        changeWeight(idx);
                                      },
                                    ),
                                  )));
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 12.0),
                        child: GestureDetector(
                            child: Icon(
                              Icons.calculate,
                              color: Colors.deepOrange[300],
                              size: 50.0,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => plateCalculator()));
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 12.0),
                        child: GestureDetector(
                            child: Icon(
                              Icons.timer,
                              color: Colors.deepOrange[300],
                              size: 50.0,
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => timer()));
                            }),
                      )
                    ],
                  )
                ])));
  }


  /**************** FORM FUNCTIONS FOR ADDING A WORKOUT ****************/

  //form to add a workout
  Future<void> addWorkoutForm() {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Add Workout"),
              content: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Form(
                      key: add_workout_form,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: addWorkoutInput() + addWorkoutButtons(),
                      ))));
        });
  }

//input for changeCardNameForm()
  List<Widget> addWorkoutInput() {
    return [
      TextFormField(
        key: Key("workout_name_key"),
        decoration: InputDecoration(labelText: 'Workout Name'),
        onSaved: (String workoutName) {
          newWorkoutName = workoutName;
        },
        validator: (String workoutName) {
          //ensure a workout name
          if ((workoutName.isEmpty)) {
            return 'Please enter text';
          }
          return null;
        },
      ),
      TextFormField(
        key: Key("set_count_key"),
        decoration: InputDecoration(labelText: 'Set Count (optional)'),
        onSaved: (String setCount) {
          newWorkoutSetCount = setCount;
        },
        validator: (String setCount) {
          return null;
        },
      ),
      TextFormField(
        key: Key("weight_key"),
        decoration: InputDecoration(labelText: 'Weight (optional)'),
        onSaved: (String weightInput) {
          newWorkoutWeight = weightInput;
        },
        validator: (String weightInput) {
          return null;
        },
      )
    ];
  }

//buttons for changeCardNameForm()
  List<Widget> addWorkoutButtons() {
    return [
      Container(
          width: 250.0,
          height: 50.0,
          padding: EdgeInsets.only(
            top: 10,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              side: BorderSide(
                width: 3,
                color: Colors.black,
              ),
            ),
            key: Key("submit_key"),
            onPressed: addWorkoutValidation,
            child: Text(
              "Add Workout",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          )),
    ];
  }

  //validates form for renaming a card
  bool addWorkoutValidation() {
    final form = add_workout_form.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        //get current date
        DateTime now = new DateTime.now();
        DateTime date = new DateTime(now.year, now.month, now.day);

        newWorkoutWeight = newWorkoutWeight + " " + date.toString().split(" ")[0];

        // create the value array
        List value_holder = [newWorkoutSetCount, newWorkoutWeight];

        // add to workout data
        workoutData[newWorkoutName] = value_holder;

        // Sync the map
        updateDataLists();

        // SYNC WITH FIREBASE
      });
      return true;
    }
    return false;
  }

  /**************** FORM FUNCTIONS FOR CHANGING WEIGHT ****************/

  //form to rename a card
  Future<void> changeWeight(String idx) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Change Weight"),
              content: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Form(
                      key: change_weight_rename,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        changeWeightInput(idx) + changeWeightButtons(),
                      ))));
        });
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
          padding: EdgeInsets.only(
            top: 10,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              side: BorderSide(
                width: 3,
                color: Colors.black,
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

        //get current date
        DateTime now = new DateTime.now();
        DateTime date = new DateTime(now.year, now.month, now.day);

        //set count is held in index 1 so ensure not to overwrite that
        if(value_holder.length == 0)
        {
          value_holder[1] = updatedValue + " " + date.toString().split(" ")[0];
        }
        else
        {
          value_holder.add(updatedValue + " " + date.toString().split(" ")[0]);
        }

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
              content: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Form(
                      key: set_count_rename,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        changeSetCountInput(idx) + changeSetCountButtons(),
                      ))));
        });
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
          padding: EdgeInsets.only(
            top: 10,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              side: BorderSide(
                width: 3,
                color: Colors.black,
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
              content: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Form(
                      key: workout_rename_key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: workoutNameInput(idx) + workoutNameButtons(),
                      ))));
        });
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
          padding: EdgeInsets.only(
            top: 10,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              side: BorderSide(
                width: 3,
                color: Colors.black,
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
              content: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Form(
                      key: rename_card_key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: renameCardInput() + renameCardButtons(),
                      ))));
        });
  }

//input for changeCardNameForm()
  List<Widget> renameCardInput() {
    return [
      TextFormField(
        key: Key("input_key"),
        onSaved: (String newName) {
          //set the index so validation function can use it later
          newCardName = newName;
          newDocument = true;
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
          padding: EdgeInsets.only(
            top: 10,
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              side: BorderSide(
                width: 3,
                color: Colors.black,
              ),
            ),
            key: Key("submit_key"),
            onPressed: folderValidation,
            child: Text(
              "Rename Card",
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
        currentCardName = newCardName;
      });
      return true;
    }
    return false;
  }
}