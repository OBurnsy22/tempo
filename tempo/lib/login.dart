import 'package:flutter/material.dart';
import 'auth.dart';

class login extends StatefulWidget {

  @override
  loginState createState() => loginState();
}

class loginState extends State<login> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: () => Authentication().googleSignIn(),
              color: Colors.white,
              textColor: Colors.black,
              child: Text('Login with Google'),
            ),
            MaterialButton(
              onPressed: () => Authentication().signOut(),
              color: Colors.white,
              textColor: Colors.black,
              child: Text('Logout with Google')
            )
          ],
        ),
      ),
    );
  }
}