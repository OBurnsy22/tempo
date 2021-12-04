import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase.dart' as fb;
import 'package:dropdown_formfield/dropdown_formfield.dart';


//class to track workouts and their timestamps
class _WorkoutTimestamps {
  _WorkoutTimestamps(this.weight, this.date);

  final String weight;
  final double date;
}

class analyticsHome extends StatefulWidget {
  @override
  analyticsHomeState createState() => analyticsHomeState();
}

class analyticsHomeState extends State<analyticsHome>
    with AutomaticKeepAliveClientMixin<analyticsHome> {
  //https://pub.dev/packages/syncfusion_flutter_charts/example
  final graph_form_key = GlobalKey<FormState>();
  bool generated = true;
  List graphs = [];
  bool data_retrieved = false;
  List<QueryDocumentSnapshot> user_data = [];

  String calculateChoice;
  String fromChoice;

  List<_WorkoutTimestamps> chartData = [
    _WorkoutTimestamps('100', 0),
    _WorkoutTimestamps('90', 2),
    _WorkoutTimestamps('300', 3),
    _WorkoutTimestamps('20', 1),
  ];

  @override
  void initState() {
    super.initState();
    //generateGraphs();
    retrieveData();
  }

  Future<void> retrieveData() async {
    user_data = await fb.fireDatabase().retrieveUserData();
    print(user_data.length);
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
                child: Column(children: <Widget>[
                  Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.50,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // Chart titles
                        title: ChartTitle(text: 'Half yearly sales analysis'),
                        // Enable legend
                        legend: Legend(isVisible: true),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<_WorkoutTimestamps, String>>[
                          LineSeries<_WorkoutTimestamps, String>(
                              dataSource: chartData,
                              xValueMapper: (_WorkoutTimestamps workout, _) =>
                                  workout.weight,
                              yValueMapper: (_WorkoutTimestamps workout, _) =>
                                  workout.date,
                              name: 'Workout Weight',
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true))
                        ],
                      )),
                ]))),
            floatingActionButton: FloatingActionButton(
                onPressed: AddGraphForm,
                child: Icon(
                  Icons.auto_graph,
                  size: 30,
                  color: Colors.deepOrange[300],
                ),
                backgroundColor: Colors.white,
            ),
      );
    } else {
      //data hasn't been retrieved yet so return progress indicator
      return CircularProgressIndicator(
        backgroundColor: Colors.grey.shade700,
        color: Colors.deepOrange[300],
      );
    }
  }

  Future<void> generateGraphs() async {
    for (int i = 0; i < 5; i++) {
      graphs.add(Container(
          color: Colors.white,
          //width: MediaQuery.of(context).size.width * 0.85,
          //height: MediaQuery.of(context).size.height * 0.50,
          width: 200,
          height: 200,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'Half yearly sales analysis'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_WorkoutTimestamps, String>>[
              LineSeries<_WorkoutTimestamps, String>(
                  dataSource: chartData,
                  xValueMapper: (_WorkoutTimestamps workout, _) =>
                      workout.weight,
                  yValueMapper: (_WorkoutTimestamps workout, _) => workout.date,
                  name: 'Workout Weight',
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ],
          )));
    }
    setState(() {
      print("Graphs generated");
      generated = true;
    });
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
      DropDownFormField(
        titleText: 'Track Workout Weight:',
        hintText: 'Select a card:',
        value: calculateChoice,
        onSaved: (value) {
          setState(() {
            calculateChoice = value;
          });
        },
        onChanged: (value) {
          setState(() {
            calculateChoice = value;
          });
        },
        dataSource: [ //this just needs to be a list
          {
            "display": user_data[0].id.toString().substring(2, user_data[0].id.length-5),
            "value": user_data[0].id.toString().substring(2, user_data[0].id.length-5)
          },
          {
            "display": "there",
            "value": "there"
          },
        ],
        textField: "display",
        valueField: "value",
      )
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
              "Create Graph",
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
      setState(() {
        /*
        //add new folder to firebase
        fb.fireDatabase().firebaseCreate(_folder, "f");
        data_retrieved = false;
        retrieveData();
        */
      });
      return true;
    }
    return false;
  }

  @override
  bool get wantKeepAlive => true;
}
