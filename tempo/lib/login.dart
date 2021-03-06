import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'globals.dart' as globals;
import 'package:google_sign_in/google_sign_in.dart';
import 'main.dart';
import 'google_auth.dart';

class login extends StatefulWidget {
  @override
  loginState createState() => loginState();
}

class loginState extends State<login> {
  @override
  void initState() {
    initCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 105,
              child: CircleAvatar(
                  backgroundColor: Colors.deepOrange[300],
                  radius: 100,
                  child: Stack(
                    children: <Widget>[
                      Icon(
                        Icons.fitness_center_outlined,
                        size: 180,
                        color: Colors.black,
                      ),
                      Icon(
                        Icons.fitness_center_outlined,
                        size: 170,
                        color: Colors.white,
                      )
                    ],
                  )
              ),
            ),
            Container(
              child: Stack(children: <Widget>[
                Container(
                    child: Text(
                      "tempo",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 55,
                      ),
                    )),
                Container(
                    child: Text(
                      "tempo",
                      style: TextStyle(
                        color: Colors.deepOrange[300],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 50,
                      ),
                    ))
              ]),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 80.0
              ),
              child: MaterialButton(
                onPressed: () => singInErrorCatcher(),
                color: Colors.white,
                textColor: Colors.black,
                child: Text('Login with Google'),
              )
            ),
          ],
        ),
      ),
    );
  }

  void initCurrentUser() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user != null) {
        print(user.uid);
        setState(() {
          globals.user = user;
          globals.signedIn = true;
        });
      }
    });
  }

  /* AUTHENITCATION FUNCTIONS */
  //function called before google sign in, to catch
  //any potential sign in erros
  Future<void> singInErrorCatcher() async {
    try {
      await googleAuth().googleSignIn();
      globals.signedIn = true;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => navigator()),
      );
    } catch (error) {
      print(error);
    }
  }

  /*
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
    setState(() {
      globals.signedIn = true;
      //globals.user = googleUser as User;
    });

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //signs out current user and returns them to homepage
  Future<void> googleSignOut() async {
    print("in google sign out");
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    setState(() {
      print("In set state for google sign out");
      globals.user = null;
      globals.signedIn = false;
    });
  } */

}
