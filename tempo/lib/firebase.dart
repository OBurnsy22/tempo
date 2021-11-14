import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'globals.dart' as globals;
import 'dart:math';

class fireDatabase {

  Future<void> updateCollection(Map<String, dynamic> workoutData, String collectionName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      firestore.collection(globals.user.email).doc(collectionName).set(workoutData);
    } catch(error) {
      print("Exception caught in firebase updateCollection: $error");
    }
  }




  Future<void> firebaseCreate(String name, String type) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    //print(globals.user.uid);
    print(globals.user.email);

    //append a pound and 5 digits to the end of class name, so users
    //can be enrolled in many classes with the same name

    String classUniqueID = "";
    var rng = new Random();
    for (var i = 0; i < 4; i++) {//generates 0-9
      classUniqueID += rng.nextInt(10).toString();
    }
    classUniqueID;

    firestore
        .collection(globals.user.email)
        .doc(type + "_" + name + "_" + classUniqueID)
        .set({
      //set attributes here
      //'test': 'test',
    })
        .then((value) => print("Successfully added to database"))
        .catchError((error) => print(error));
  }


  //example of how to retrieve data from firebase
    Future<List<QueryDocumentSnapshot>> retrieveUserData() async{
      List<QueryDocumentSnapshot> user_data = [];
      /*
        NOTE: If a user doesn't have an existing collection it will hang here, so throw it in a
        try catch block
       */
      try{
        QuerySnapshot snap = await FirebaseFirestore.instance.collection(globals.user.email).get();
        snap.docs.forEach((element) {
          user_data.add(element);
        });

      } catch (e) {
        print(e);
      }
      //loops through all documents, appending their names to the myDocs list
      return user_data;
  }


  //use this function to retrieve all data from firebase
  /*
  Future<void> retrieveClasses() async{
    QuerySnapshot snap = await FirebaseFirestore.instance.collection(globals.user.email).get();
    //loops through all documents, appending their names to the myDocs list
    snap.docs.forEach((element) {
      var icon = element.get("classIcon");
      //allClassesIcons.add(icon);
      allClasses.add(element);
    });
    print(allClasses.length);
    setState(() {
      classesRetrieved = true;
    });
  }*/

}