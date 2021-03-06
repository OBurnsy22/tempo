import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase.dart' as fb;
import 'package:bordered_text/bordered_text.dart';



//class to track workouts and their timestamps
class _WorkoutTimestamps {
  _WorkoutTimestamps(this.weight, this.date);

  final String weight;
  final DateTime date;
}

class analyticsHome extends StatefulWidget {
  @override
  analyticsHomeState createState() => analyticsHomeState();
}

class analyticsHomeState extends State<analyticsHome> {
  //https://pub.dev/packages/syncfusion_flutter_charts/example
  Map<String, dynamic> workoutData;

  final graph_form_key = GlobalKey<FormState>();
  bool generated = true;
  List graphs = [];
  bool data_retrieved = false;

  List<QueryDocumentSnapshot> user_data = [];
  List<String> workoutNameData = [];

  String calculateChoice;
  String fromChoice;

  String selectedCard;

  //List<_WorkoutTimestamps> chartData = [];

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  Future<void> retrieveData() async {
    user_data = await fb.fireDatabase().retrieveUserData();
    print(user_data.length);
    for(int i=0; i<user_data.length; i++)
    {
      workoutNameData.add(user_data[i].id.substring(2, user_data[i].id.length-5).toString());
    }
    workoutNameData.length > 0 ? selectedCard = workoutNameData[0] : selectedCard = "*No Available Cards*";
    setState(() {
      data_retrieved = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data_retrieved) {
      return Scaffold(
        backgroundColor: Colors.grey.shade700,
        body: Center(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children: generateGraph()
                ))),
            floatingActionButton: FloatingActionButton(
                onPressed: AddGraphForm,
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.deepOrange[300],
                ),
                backgroundColor: Colors.white,
            ),
      );
    } else {
      //data hasn't been retrieved yet so return progress indicator
      return Container(
        color: Colors.grey.shade700,
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey.shade700,
          color: Colors.deepOrange[300],
        ),
      );
    }
  }


  List<Widget> generateGraph() {
    List<Widget> graphs = [];
    /* Append the time values and workout weight as x y values to chartData */
    if(workoutData != null)
      {
        //chartData.clear();
        List workoutNames = workoutData.keys.toList();
        List workoutWeightAndTime = workoutData.values.toList();

        List<List<_WorkoutTimestamps>> allData = [];
        for(int i=0; i<workoutWeightAndTime.length; i++)
        {
          List<_WorkoutTimestamps> chartData = [];
          for(int x=0; x<workoutWeightAndTime[i].length; x++)
          {
            if(x != 0 && workoutWeightAndTime[i][x] != null)
            {
              var data = workoutWeightAndTime[i][x].toString().split(" ");
              var date_data = data[1].split("-");
              chartData.add(_WorkoutTimestamps(data[0], DateTime(int.parse(date_data[0]), int.parse(date_data[1]), int.parse(date_data[2]))));
            }
          }

          allData.add(chartData);

          //add divider
          graphs.add(Divider(
            height: 20,
            thickness: 20,
            color: Colors.grey.shade700,
          ));
          //create a new chart with the data
          graphs.add(Container(
              decoration: BoxDecoration(
                color: Colors.white,
                  border: Border.all(
                    color: Colors.deepOrange[300],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              //color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.5,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart titles
                title: ChartTitle(text: workoutNames[i]),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_WorkoutTimestamps, String>>[
                  LineSeries<_WorkoutTimestamps, String>(
                      color: Colors.deepOrange[300],
                      dataSource: allData[i],
                      xValueMapper: (_WorkoutTimestamps workout, _) =>
                      workout.date.millisecondsSinceEpoch.toString(),
                      yValueMapper: (_WorkoutTimestamps workout, _) =>
                      int.parse(workout.weight),
                      name: 'Workout Weight',
                      dataLabelSettings:
                      DataLabelSettings(isVisible: true))
                ],
                axisLabelFormatter: (AxisLabelRenderDetails args) {
                  String text;
                  if (args.axisName == 'primaryXAxis') {
                    print(args.value);
                    text = DateTime.fromMillisecondsSinceEpoch(
                        args.value.toInt())
                        .month
                        .toString() +
                        '-' +
                        DateTime.fromMillisecondsSinceEpoch(args.value.toInt())
                            .day
                            .toString();
                  } else {
                    text = args.text;
                  }
                  return ChartAxisLabel(text, args.textStyle);
                },
              )));
          //add divider
          graphs.add(Divider(
            height: 20,
            thickness: 20,
            color: Colors.grey.shade700,
          ));
        }

      } else {
      graphs.add(BorderedText(
          strokeWidth: 3.0,
          strokeColor: Colors.black,
          child: Text(
            "No Graphs",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          )));
    }
    return graphs;
  }


  //form to add a new graph
  Future<void> AddGraphForm() {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Add A Graph"),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.height * 0.50,
                child: Form(
                    key: graph_form_key,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: graphInput() + graphButtons())),
              ));
        });
  }

  //input for adding a new graph
  List<Widget> graphInput() {
    return [
      Text("Track workout weight data from selected card: "),
      DropdownButton(
        value: selectedCard,
        hint: Text("Select a card:"),
        items: workoutNameData.map<DropdownMenuItem<String>>((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items)
          );
        }
        ).toList(),
          onChanged: (String newValue) {
            setState(() {
              selectedCard = newValue;
            });
          }
      ),

    ];
  }

  //buttons for adding a new graph
  List<Widget> graphButtons() {
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
              //onPrimary: Color(0xFFE0F7FA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
              side: BorderSide(
                width: 3,
                color: Colors.black,
              ),
            ),
            key: Key("submit_key"),
            onPressed: graphValidation,
            child: Text(
              "Create Graphs",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          )),
    ];
  }

  //validates form for creating a folder
  bool graphValidation() {
    final form = graph_form_key.currentState;
    if (form.validate()) {
      form.save();
      /*
          1. Get the workout data for the selected workout
          2. Seperate the data into an x and y list
          3. Dynamically generate a graph with said lists
      */
      for(int i=0; i<user_data.length; i++)
      {
        if(user_data[i].id.contains(selectedCard))
        {
          /*setState(() {
            workoutData = user_data[i].data();
          });*/
          workoutData = user_data[i].data();
          setState(() {
            generateGraph();
          });
        }
      }
      return true;
    }
    return false;
  }

}
