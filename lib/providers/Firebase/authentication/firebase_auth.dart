import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:take_home/Screens/Home/home.dart';
import 'package:take_home/Screens/login_screen/login_screen.dart';

class Authenticator {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void createAccount(context, email, password, displayName) {
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          auth.currentUser!.updatePhotoURL('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png');
      auth.currentUser!.updateDisplayName(displayName).then((value) {

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()
        ), (route) => false);
      });
    }).catchError((e) {
      print(e);
    });
  }

  void login(context, email, password) {
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()
      ), (route) => false);
    });
  }

  Future<void> signInGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (user != null) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()
        ), (route) => false);
      } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
      else {}
    }
  }

  void signout(context) async {
    await auth.signOut();
    await GoogleSignIn().signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
  }
}
