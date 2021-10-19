import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase.dart' as fb;


class cardsHome extends StatefulWidget {

  @override
  cardsHomeState createState() => cardsHomeState();
}

class cardsHomeState extends State<cardsHome> with AutomaticKeepAliveClientMixin<cardsHome> {
  final folder_form_key = GlobalKey<FormState>();
  final card_form_key = GlobalKey<FormState>();
  String _folder; //might want to change this to an array
  String _card;   //might want to change this to an array
  bool data_retrieved = false;
  List<QueryDocumentSnapshot> user_data = [];

  @override
  void initState() {
    super.initState();
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
    if(data_retrieved){
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
                                  child: GestureDetector(
                                      onTap: AddCardForm,
                                      child: Icon(
                                        Icons.add_outlined,
                                        size: 40,
                                      )
                                  )
                              )
                            ],
                          ),
                        )
                    ),
                  )
              ),
              Expanded(
                  child: Container (
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.84,
                        //add height HERE
                        child: ListView.builder(
                            itemCount: user_data.length,
                            itemBuilder: (context, index) {
                              QueryDocumentSnapshot data = user_data[index];
                              return Card(
                                  child: ListTile(
                                      title: Text(data.get("test")),
                                      onTap: () {
                                        // NAVIGATE TO NEW VIEW HERE
                                      }
                                  )
                              );
                            }
                        )
                    ),
                  )
              )
            ],
          ),
        ),
      );
    } else { //data hasn't been retrieved yet so return progress indicator
      return CircularProgressIndicator(
        backgroundColor: Color(0xFFE0F7FA),
      );
    }
  }



  // form for adding folders
  Future<void> AddFolderForm() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add A Folder"),
          content: Form(
              key: folder_form_key,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: folderInput() + folderButtons()
              )
          ),
        );
      }
    );
  }

  //input for AddFolderForm()
  List<Widget> folderInput() {
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
  List<Widget> folderButtons() {
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
          )
      ),
    ];
  }

  //validates form for creating a folder
  bool folderValidation(){
    final form = folder_form_key.currentState;
    if(form.validate()){
      form.save();
      setState(() {
        //add new folder to firebase
        fb.fireDatabase().firebaseCreate(_folder, "folder");
      });
      return true;
    }
    return false;
  }


  //form for creating cards
  Future<void> AddCardForm() {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add A Card"),
            content: Form(
                key: card_form_key,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: cardInput() + cardButtons()
                )
            ),
          );
        }
    );
  }

  //input for AddCardForm()
  List<Widget> cardInput() {
    return [
      TextFormField(
        key :Key("input_key"),
        onSaved: (String cardName) {
          //save here
          _card = cardName;
        },
        validator: (String cardName) {
          //ensure a folder name was entered
          if ((cardName.isEmpty)) {
            return 'Please enter text';
          }

          return null;
        },
      )
    ];
  }

  //buttons for AddFolderForm
  List<Widget> cardButtons() {
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
            onPressed: cardValidation,
            child: Text(
              "Create Card",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          )
      ),
    ];
  }

  //validates form for creating a card
  bool cardValidation(){
    final form = card_form_key.currentState;
    if(form.validate()){
      form.save();
      setState(() {
        //create new card in firebase
        //add new folder to firebase
        fb.fireDatabase().firebaseCreate(_card, "card");
      });
      return true;
    }
    return false;
  }



  @override
  bool get wantKeepAlive => true;
}