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


  Future<void>updateAndRenameCollection(Map<String, dynamic> workoutData, String oldCollectionName, String newCollectionName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    //add the leading and ending characters to the new collection name
    newCollectionName = oldCollectionName.substring(0, 2) + newCollectionName + oldCollectionName.substring(oldCollectionName.length-5, oldCollectionName.length);

    //create the new collection
    firestore.collection(globals.user.email).doc(newCollectionName).set(workoutData);

    //delete the old one
    firestore.collection(globals.user.email).doc(oldCollectionName).delete();
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


  Future<void> deleteWorkoutCard(String cardName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection(globals.user.email).doc(cardName).delete();
  }

}