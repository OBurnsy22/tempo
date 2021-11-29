import 'package:flutter/material.dart';

class plateCalculator extends StatefulWidget {
  @override
  plateCalculatorState createState() => plateCalculatorState();
}

class plateCalculatorState extends State<plateCalculator> {
  int weight;
  final change_starting_weight = GlobalKey<FormState>();

  int fourtyFiveCount;
  int thirtyFiveCount;
  int twentyFiveCount;
  int fifteenCount;
  int tenCount;
  int fiveCount;

  @override
  void initState() {
    weight = 45;
    fourtyFiveCount = thirtyFiveCount = twentyFiveCount = fifteenCount = tenCount = fiveCount = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            /*
            GestureDetector(
              child: Text(
                  weight.toString(),
                  style: TextStyle(
                      fontSize: 45,
                      decoration: TextDecoration.underline
                  )
              ),
              onTap: () {
                changeStartingWeight();
              }
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: GestureDetector(
                        child: Text(
                            "-",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        onTap: () {
                          subtract(45);
                          fourtyFiveCount--;
                        }
                    )
                  )
                ),
                Align(
                    alignment: Alignment.center,
                        child: Text(
                            "45",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: GestureDetector(
                            child: Text(
                                "+",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            onTap: () {
                              add(45);
                              fourtyFiveCount++;
                            }
                        )
                    )
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(": " + fourtyFiveCount.toString(),
                      style: TextStyle(
                          fontSize: 20,
                      )),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: GestureDetector(
                            child: Text(
                                "-",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            onTap: () {
                              subtract(35);
                              thirtyFiveCount--;
                            }
                        )
                    )
                ),
                Align(
                    alignment: Alignment.center,
                        child: Text(
                            "35",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: GestureDetector(
                            child: Text(
                                "+",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            onTap: () {
                              add(35);
                              thirtyFiveCount++;
                            }
                        )
                    )
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(": " + thirtyFiveCount.toString(),
                      style: TextStyle(
                          fontSize: 20,
                      )),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: GestureDetector(
                            child: Text(
                                "-",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            onTap: () {
                              subtract(25);
                              twentyFiveCount--;
                            }
                        )
                    )
                ),
                Align(
                    alignment: Alignment.center,
                        child: Text(
                            "25",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: GestureDetector(
                            child: Text(
                                "+",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            onTap: () {
                              add(25);
                              twentyFiveCount++;
                            }
                        )
                    )
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(": " + twentyFiveCount.toString(),
                      style: TextStyle(
                          fontSize: 20,
                      )),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: GestureDetector(
                            child: Text(
                                "-",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            onTap: () {
                              subtract(15);
                              fifteenCount--;
                            }
                        )
                    )
                ),
                Align(
                    alignment: Alignment.center,
                        child: Text(
                            "15",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: GestureDetector(
                            child: Text(
                                "+",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            onTap: () {
                              add(15);
                              fifteenCount++;
                            }
                        )
                    )
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(": " + fifteenCount.toString(),
                      style: TextStyle(
                          fontSize: 20,
                      )),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: GestureDetector(
                            child: Text(
                                "-",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            onTap: () {
                              subtract(10);
                              tenCount--;
                            }
                        )
                    )
                ),
                Align(
                    alignment: Alignment.center,
                        child: Text(
                            "10",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: GestureDetector(
                            child: Text(
                                "+",
                              style: TextStyle(
                              fontSize: 30,
                            ),
                            ),
                            onTap: () {
                              add(10);
                              tenCount++;
                            }
                        )
                    )
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(": " + tenCount.toString(),
                      style: TextStyle(
                          fontSize: 20,
                      )),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: GestureDetector(
                            child: Text(
                                "-",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            onTap: () {
                              subtract(5);
                              fiveCount--;
                            }
                        )
                    )
                ),
                Align(
                    alignment: Alignment.center,
                        child: Text(
                            "5",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: GestureDetector(
                            child: Text(
                                "+",
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            onTap: () {
                              add(5);
                              fiveCount++;
                            }
                        )
                    )
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(": " + fiveCount.toString(),
                      style: TextStyle(
                          fontSize: 20,
                      )),
                )
              ],
            )
          ]
        )
      )
    );
  }

  void subtract(int amount) {
    setState(() {
      weight = ((weight - amount) < 0) ? weight : weight -= amount;
    });
  }

  void add(int amount) {
    setState(() {
      weight += amount;
    });
  }

  /**************** FORM FUNCTIONS FOR CHANGING STARTING WEIGHT ****************/

  //form to rename a card
  Future<void> changeStartingWeight() {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Change Starting Weight"),
              content: Form(
                  key: change_starting_weight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: changeStartingWeightInput() + changeStartingWeightButtons(),
                  )
              )
          );
        }
    );
  }

//input for changeCardNameForm()
  List<Widget> changeStartingWeightInput() {
    return [
      TextFormField(
        key: Key("input_key"),
        onSaved: (String weightInput) {

        },
        validator: (String newName) {
          //ensure a name was entered
          if ((newName.isEmpty)) {
            return 'Please enter text';
          }
          else if(!(RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$').hasMatch(newName))) {
            return 'Numbers only';
          }
          return null;
        },
      )
    ];
  }


//buttons for changeCardNameForm()
  List<Widget> changeStartingWeightButtons() {
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
            onPressed: changeStartingWeightValidation,
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
  bool changeStartingWeightValidation() {
    final form = change_starting_weight.currentState;
    if (form.validate()) {
      form.save();
      setState(() {

      });
      return true;
    }
    return false;
  }
}