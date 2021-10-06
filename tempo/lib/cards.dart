import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class cardsHome extends StatefulWidget {

  @override
  cardsHomeState createState() => cardsHomeState();
}

class cardsHomeState extends State<cardsHome> with AutomaticKeepAliveClientMixin<cardsHome> {
  final form_key = GlobalKey<FormState>();
  String _folder;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.80,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.green,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 0.07,
                  child: Container(
                    color: Colors.yellow,
                    child: Row(
                      children: <Widget> [
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: AddFolderForm,
                            child: Icon(
                              Icons.create_new_folder_outlined,
                              size: 40,
                            ),
                          )
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.add_outlined,
                              size: 40,
                            )
                        )
                      ],
                    ),
                  )
                ),
              )
            )
          ],
        ),
      ),
    );
  }


  /*
    Use showDialog to return the form
    https://stackoverflow.com/questions/54480641/flutter-how-to-create-forms-in-popup


   */

  Form AddFolderForm() {
    return Form(
        key: form_key,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: input() + buttons()
        )
    );
  }

  //input for AddFolderForm()
  List<Widget> input() {
    return [
      TextFormField(
        key :Key("input_key"),
        onSaved: (String folderName) {
          //save here
          _folder = folderName;
        },
        validator: (String folderName) {
          //ensure a folder name was entered
          if ((folderName.isEmpty)) {
            return 'Please enter text';
          }

          return null;
        },
      )
    ];
  }

  //buttons for AddFolderForm
  List<Widget> buttons() {
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
            onPressed: validateForm,
            child: Text(
              "Create Class",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          )
      ),
    ];
  }

  //validates form for creating a folder
  bool validateForm(){
    final form = form_key.currentState;
    if(form.validate()){
      form.save();
      setState(() {
        //CREATE DATA HERE
        //firebaseCreateClass();
      });
      return true;
    }
    return false;
  }



  @override
  bool get wantKeepAlive => true;
}