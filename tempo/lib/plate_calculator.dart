import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';

class plateCalculator extends StatefulWidget {
  @override
  plateCalculatorState createState() => plateCalculatorState();
}

class plateCalculatorState extends State<plateCalculator> {
  int weight;
  final change_starting_weight = GlobalKey<FormState>();

  //individual counts
  int fourtyFiveCount;
  int thirtyFiveCount;
  int twentyFiveCount;
  int fifteenCount;
  int tenCount;
  int fiveCount;

  //individual totals
  int fourtyFiveTotal;
  int thirtyFiveTotal;
  int twentyFiveTotal;
  int fifteenTotal;
  int tenTotal;
  int fiveTotal;

  @override
  void initState() {
    weight = 45;
    fourtyFiveCount = thirtyFiveCount = twentyFiveCount = fifteenCount = tenCount = fiveCount = 0;
    fourtyFiveTotal = thirtyFiveTotal = twentyFiveTotal = fifteenTotal = tenTotal = fiveTotal = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade700,
        appBar: AppBar(
          toolbarHeight: 40,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.deepOrange[300],
            )
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            /*
            /* CHANGE THE BAR WEIGHT */
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

            /* LABELS */
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 60,
                        bottom: 20,
                    ),
                    child: BorderedText(
                      strokeWidth: 3.0,
                      strokeColor: Colors.black,
                      child: Text(
                        "Weight:",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          /*
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2
                          ..color = Colors.black*/

                        ),
                      )
                    )

                  )
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 80,
                      bottom: 20,
                    ),
                    child: BorderedText(
                      strokeWidth: 3.0,
                      strokeColor: Colors.black,
                      child: Text(
                        "Count:",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      )
                    )
                  ),
                )
              ]
            ),

            /* FOURTY FIVE */
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //weight
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 90,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: BorderedText(
                          strokeWidth: 3.0,
                          strokeColor: Colors.black,
                          child: Text(
                            "45",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        )
                      )
                  )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: 90,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      //add box decoration here for the border
                        decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 3.0, color: Colors.deepOrange[300]),
                                bottom: BorderSide(width: 1.5, color: Colors.deepOrange[300])
                            )
                        ),
                        child: Row(
                          children: [
                            //minus sign align left
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if(fourtyFiveCount-1 >= 0)
                                        {
                                          subtract(45);
                                          fourtyFiveCount--;
                                          fourtyFiveTotal-=45;
                                        }
                                      },
                                      child: BorderedText(
                                        strokeWidth: 3.0,
                                        strokeColor: Colors.black,
                                        child: Text("-",
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                            ))
                                      ),
                                    )
                                )
                            ),
                            //current count sign in the middle
                            Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: BorderedText(
                                    strokeWidth: 3.0,
                                    strokeColor: Colors.black,
                                    child: Text(
                                        fourtyFiveCount.toString(),
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ))
                                  ),
                                )
                            ),

                            Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        add(45);
                                        fourtyFiveCount++;
                                        fourtyFiveTotal+=45;
                                      },
                                      child: BorderedText(
                                        strokeWidth: 3.0,
                                        strokeColor: Colors.black,
                                        child: Text("+",
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                            ))
                                      ),
                                    )
                                )
                            ),
                          ],
                        )
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 90,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: BorderedText(
                          strokeWidth: 3.0,
                          strokeColor: Colors.black,
                          child: Text(
                            fourtyFiveTotal.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          )
                        ),
                      )
                  ),
                ),
              ],
            ),

            /* THIRTY FIVE */
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //weight
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 90,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: BorderedText(
                            strokeWidth: 3.0,
                            strokeColor: Colors.black,
                            child: Text(
                              "35",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            )
                          ),
                        )
                    ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: 90,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      //add box decoration here for the border
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(width: 1.5, color: Colors.deepOrange[300]),
                              bottom: BorderSide(width: 1.5, color: Colors.deepOrange[300]),

                            )
                        ),
                        child: Row(
                          children: [
                            //minus sign align left
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if(thirtyFiveCount-1 >= 0)
                                        {
                                          subtract(35);
                                          thirtyFiveCount--;
                                          thirtyFiveTotal-=35;
                                        }
                                      },
                                      child: BorderedText(
                                        strokeWidth: 3.0,
                                        strokeColor: Colors.black,
                                        child: Text("-",
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                            ))
                                      ),
                                    )
                                )
                            ),
                            //current count sign in the middle
                            Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: BorderedText(
                                    strokeWidth: 3.0,
                                    strokeColor: Colors.black,
                                    child: Text(thirtyFiveCount.toString(),
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ))
                                  ),
                                )
                            ),

                            Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        add(35);
                                        thirtyFiveCount++;
                                        thirtyFiveTotal+=35;
                                      },
                                      child: BorderedText(
                                        strokeWidth: 3.0,
                                        strokeColor: Colors.black,
                                        child: Text("+",
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                            ))
                                      ),
                                    )
                                )
                            ),
                          ],
                        )
                    ),
                  )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 90,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: BorderedText(
                          strokeWidth: 3.0,
                          strokeColor: Colors.black,
                          child: Text(
                            thirtyFiveTotal.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          )
                        ),
                      )
                  )
                ),
              ],
            ),


            /* TWENTY FIVE */
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //weight
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 90,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: BorderedText(
                          strokeWidth: 3.0,
                          strokeColor: Colors.black,
                          child: Text(
                            "25",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        )
                      )
                  )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: 90,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      //add box decoration here for the border
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(width: 1.5, color: Colors.deepOrange[300]),
                              bottom: BorderSide(width: 1.5, color: Colors.deepOrange[300]),

                            )
                        ),
                        child: Row(
                          children: [
                            //minus sign align left
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if(twentyFiveCount-1 >= 0)
                                        {
                                          subtract(25);
                                          twentyFiveCount--;
                                          twentyFiveTotal-=25;
                                        }
                                      },
                                      child: BorderedText(
                                        strokeWidth: 3.0,
                                        strokeColor: Colors.black,
                                        child: Text("-",
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                            ))
                                      ),
                                    )
                                )
                            ),
                            //current count sign in the middle
                            Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: BorderedText(
                                    strokeWidth: 3.0,
                                    strokeColor: Colors.black,
                                    child: Text(twentyFiveCount.toString(),
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ))
                                  ),
                                )
                            ),

                            Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        add(25);
                                        twentyFiveCount++;
                                        twentyFiveTotal+=25;
                                      },
                                      child: BorderedText(
                                        strokeWidth: 3.0,
                                        strokeColor: Colors.black,
                                        child: Text("+",
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                            ))
                                      ),
                                    )
                                )
                            ),
                          ],
                        )
                    ),
                  )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 90,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: BorderedText(
                          strokeWidth: 3.0,
                          strokeColor: Colors.black,
                          child: Text(
                            twentyFiveTotal.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          )
                        ),
                      )
                  )
                ),
              ],
            ),


            /* FIFTEEN */
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //weight
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 90,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: BorderedText(
                          strokeWidth: 3.0,
                          strokeColor: Colors.black,
                          child: Text(
                            "15",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          )
                        ),
                      )
                  )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: 90,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      //add box decoration here for the border
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(width: 1.5, color: Colors.deepOrange[300]),
                              bottom: BorderSide(width: 1.5, color: Colors.deepOrange[300]),

                            )
                        ),
                        child: Row(
                          children: [
                            //minus sign align left
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if(fifteenCount-1 >= 0)
                                        {
                                          subtract(15);
                                          fifteenCount--;
                                          fifteenTotal-=15;
                                        }
                                      },
                                      child: BorderedText(
                                        strokeWidth: 3.0,
                                        strokeColor: Colors.black,
                                        child: Text("-",
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                            ))
                                      ),
                                    )
                                )
                            ),
                            //current count sign in the middle
                            Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: BorderedText(
                                    strokeWidth: 3.0,
                                    strokeColor: Colors.black,
                                    child: Text(fifteenCount.toString(),
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ))
                                  ),
                                )
                            ),

                            Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        add(15);
                                        fifteenCount++;
                                        fifteenTotal+=15;
                                      },
                                      child: BorderedText(
                                        strokeWidth: 3.0,
                                        strokeColor: Colors.black,
                                        child: Text("+",
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                            ))
                                      ),
                                    )
                                )
                            ),
                          ],
                        )
                    ),
                  )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 90,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: BorderedText(
                          strokeWidth: 3.0,
                          strokeColor: Colors.black,
                          child: Text(
                            fifteenTotal.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          )
                        ),
                      )
                  )
                ),
              ],
            ),


            /* TEN */
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: 90,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: BorderedText(
                                strokeWidth: 3.0,
                                strokeColor: Colors.black,
                                child: Text(
                                  "10",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                )
                              ),
                            )
                        )
                    ),
                    //weight
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.50,
                        height: 90,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            //add box decoration here for the border
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(width: 1.5, color: Colors.deepOrange[300]),
                                    bottom: BorderSide(width: 1.5, color: Colors.deepOrange[300]),

                                  )
                              ),
                              child: Row(
                                children: [
                                  //minus sign align left
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              if(tenCount-1 >= 0)
                                              {
                                                subtract(10);
                                                tenCount--;
                                                tenTotal-=10;
                                              }
                                            },
                                            child: BorderedText(
                                              strokeWidth: 3.0,
                                              strokeColor: Colors.black,
                                              child: Text("-",
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.white,
                                                  ))
                                            ),
                                          )
                                      )
                                  ),
                                  //current count sign in the middle
                                  Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: BorderedText(
                                          strokeWidth: 3.0,
                                          strokeColor: Colors.black,
                                          child: Text(tenCount.toString(),
                                              style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                              ))
                                        ),
                                      )
                                  ),

                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              add(10);
                                              tenCount++;
                                              tenTotal+=10;
                                            },
                                            child: BorderedText(
                                              strokeWidth: 3.0,
                                              strokeColor: Colors.black,
                                              child: Text("+",
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.white,
                                                  ))
                                            ),
                                          )
                                      )
                                  ),
                                ],
                              )
                          ),
                        )
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: 90,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: BorderedText(
                                strokeWidth: 3.0,
                                strokeColor: Colors.black,
                                child: Text(
                                  tenTotal.toString(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                )
                              ),
                            )
                        )
                    ),
                  ],
                ),


            /* FIVE */
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 90,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: BorderedText(
                            strokeWidth: 3.0,
                            strokeColor: Colors.black,
                            child: Text(
                              "5",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            )
                          ),
                        )
                    )
                ),
                //weight
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    height: 90,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        //add box decoration here for the border
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(width: 1.5, color: Colors.deepOrange[300]),
                                bottom: BorderSide(width: 3, color: Colors.deepOrange[300]),
                              )
                          ),
                          child: Row(
                            children: [
                              //minus sign align left
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          if(fiveCount-1 >= 0)
                                          {
                                            subtract(5);
                                            fiveCount--;
                                            fiveTotal-=5;
                                          }
                                        },
                                        child: BorderedText(
                                          strokeWidth: 3.0,
                                          strokeColor: Colors.black,
                                          child: Text("-",
                                              style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                              ))
                                        ),
                                      )
                                  )
                              ),
                              //current count sign in the middle
                              Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: BorderedText(
                                      strokeWidth: 3.0,
                                      strokeColor: Colors.black,
                                      child: Text(fiveCount.toString(),
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                          ))
                                    ),
                                  )
                              ),

                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          add(5);
                                          fiveCount++;
                                          fiveTotal+=5;
                                        },
                                        child: BorderedText(
                                          strokeWidth: 3.0,
                                          strokeColor: Colors.black,
                                          child: Text("+",
                                              style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                              ))
                                        ),
                                      )
                                  )
                              ),
                            ],
                          )
                      ),
                    )
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 90,
                    child:Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: BorderedText(
                            strokeWidth: 3.0,
                            strokeColor: Colors.black,
                            child: Text(
                              fiveTotal.toString(),
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            )
                          ),
                        )
                    )
                ),
              ],
            ),

          /* TOTAL WEIGHT */
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(
                            right: 60,
                            top: 20,
                          ),
                          child: BorderedText(
                            strokeWidth: 3.0,
                            strokeColor: Colors.black,
                            child: Text(
                              "Total:",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            )
                          )
                      )
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: EdgeInsets.only(
                          left: 80,
                          top: 20,
                        ),
                        child: BorderedText(
                          strokeWidth: 3.0,
                          strokeColor: Colors.black,
                          child: Text(
                            weight.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          )
                        )
                    ),
                  )
                ]
            ),

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
                color: Colors.white,
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