import 'globals.dart' as globals;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class googleAuth {

  //signs the user in through google
  Future<UserCredential> googleSignIn() async {  //look at firebase auth for reference
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print(googleUser.email);
    print(googleUser.displayName);

    // Once signed in, return the UserCredential
    //setState(() {
      //globals.user = googleUser as User;
    //});

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //signs out current user and returns them to homepage
  Future<void> googleSignOut(BuildContext context) async {
    print("in google sign out");
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    //setState(() {
      print("In set state for google sign out");
      globals.user = null;
      globals.signedIn = false;
      Navigator.pop(context);
      Navigator.pop(context);
    //}); //might have to call setState() on the widget tree from whereever
          //this is being called */
  }

}