import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'globals.dart' as globals;

class Authentication {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance; //user
  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;

  //Observable<FirebaseUser> user;
  //Observable<Map<String, dynamic>>  profile;
  PublishSubject loading = PublishSubject();


  Future<User> googleSignIn() async {
    loading.add(true);
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken);

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    print("Signed in " + user.displayName);

    globals.signedIn = true;

    loading.add(false);
    return user;
  }

  void signOut() {
    _auth.signOut();
    globals.signedIn = false;
  }

}

final Authentication auth = Authentication();