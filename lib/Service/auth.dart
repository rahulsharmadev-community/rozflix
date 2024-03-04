import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rozflix/Service/RestartWidget.dart';

class DefaultUser {
  final String uid;
  final String email;
  final String displayName;
  final bool isAnonymous;
  DefaultUser({
    @required this.uid,
    this.email: "",
    this.displayName: "",
    this.isAnonymous: false,
  });
}

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _auth_forGoogleSignIn = GoogleSignIn();

  //create a user obj from firebase user
  DefaultUser _userFromFirebaseUser(User user) {
    if (user != null) {
      return DefaultUser(
          uid: user.uid,
          email: user.email,
          displayName: user.displayName,
          isAnonymous: user.isAnonymous);
    } else {
      return null;
    }
  }

  //use by provider
  Stream<DefaultUser> get user {
    return _auth.userChanges().map(_userFromFirebaseUser);
  }

  //sign in with Google
  Future signinGoogle() async {
    // print('signinfunction');

    try {
      final GoogleSignInAccount googleSignInAccount =
          await _auth_forGoogleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final UserCredential result =
          await _auth.signInWithCredential(authCredential);
      User user = result.user;
      // print(user.toString());
      return _userFromFirebaseUser(user);
    } catch (error) {
      // print("error\n\n" + error.toString());
      return null;
    }
  }

//sign in with Anonymous
  Future signinAnony() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      // print(user.toString());

      return _userFromFirebaseUser(user);
    } catch (error) {
      // print(error.toString());
      return null;
    }
  }

  //Universal sign out [any authantication method can use to signout]
  Future signOut() async {
    try {
      if (_auth != null) return await _auth.signOut();
      if (_auth_forGoogleSignIn != null)
        return await _auth_forGoogleSignIn.signOut();
    } catch (error) {
      // print('error found agains Sign out');
    }
  }
}
