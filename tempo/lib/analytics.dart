import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

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
  String graph_type = 'Time Series';
  bool generated = true;
  List graphs = [];

  List<_WorkoutTimestamps> chartData = [
    _WorkoutTimestamps('100', 0),
    _WorkoutTimestamps('200', 1),
    _WorkoutTimestamps('300', 2),
    _WorkoutTimestamps('400', 3),
  ];

  @override
  void initState() {
    super.initState();
    //generateGraphs();
  }

  @override
  Widget build(BuildContext context) {
    if (generated) {
      return Scaffold(
          backgroundColor: Colors.grey.shade700,
          body: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  /*width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.90,*/
                  children: <Widget>[
                   Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.50,
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
                              yValueMapper: (_WorkoutTimestamps workout, _) =>
                              workout.date,
                              name: 'Workout Weight',
                              dataLabelSettings:
                              DataLabelSettings(isVisible: true))
                        ],
                      )),
                    Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.50,
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
                                yValueMapper: (_WorkoutTimestamps workout, _) =>
                                workout.date,
                                name: 'Workout Weight',
                                dataLabelSettings:
                                DataLabelSettings(isVisible: true))
                          ],
                        )),
                    Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.50,
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
                                yValueMapper: (_WorkoutTimestamps workout, _) =>
                                workout.date,
                                name: 'Workout Weight',
                                dataLabelSettings:
                                DataLabelSettings(isVisible: true))
                          ],
                        )),
                ]
                )
              )


              ));
    } else {
      //data hasn't been retrieved yet so return progress indicator
      return CircularProgressIndicator(
        backgroundColor: Colors.grey.shade700,
        color: Colors.deepOrange[300],
      );
    }
  }

  /*
              Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: AddGraphForm,
                child: Icon(
                  Icons.auto_graph,
                  size: 30,
                )
              )
            )
   */

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
                height: MediaQuery.of(context).size.height * 0.20,
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
      TextFormField(
        key: Key("input_key"),
        onSaved: (String graphName) {
          //save here
          //_folder = folderName;
        },
        validator: (String graphName) {
          //ensure a folder name was entered
          if ((graphName.isEmpty)) {
            return 'Please enter text';
          }
          return null;
        },
      ),
      DropdownButton<String>(
        value: graph_type,
        underline: Container(height: 2, color: Colors.deepPurpleAccent),
        onChanged: (String newValue) {
          setState(() {
            graph_type = newValue;
          });
        },
        items: <String>['Time Series', 'Bar']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
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
