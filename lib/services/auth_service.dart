import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:t_t_project/screens/home.dart';
import 'package:t_t_project/screens/loginscreens/login.dart';
import '../screens/loginscreens/start.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _databaseRef = FirebaseDatabase.instance.ref();
  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  Future<void> signup({
    required String email,
    required String password,
    required String name,
    required String phone,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;
      await _databaseRef.child('Users').child(uid).set({
        'email': email,
        'uid': uid,
        'name': name,
        'phone': phone,
        // It's generally not recommended to store passwords directly.
        // Consider storing a password hash instead if you absolutely need to.
        // 'password': password,  //REMOVE THIS - DO NOT STORE PASSWORDS IN PLAIN TEXT
      });

      Fluttertoast.showToast(
        msg: 'Sign up successfully',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16,
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => loginScreen()));

    } on FirebaseAuthException catch(e){
      String message ='';
      if (e.code == 'weak-password'){
        message = 'the password provided is too weak.';
      } else if (e.code == 'email-already-in-use'){
        message = 'An account already exists with that email.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14,
      );
    }
    catch (e) {
    }
  }

  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => homeScreen()));

    } on FirebaseAuthException catch(e){
      String message ='';
      if (e.code == 'user-not-found'){
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password'){
        message = 'Wrong password provided for that user.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14,
      );
    }
    catch (e) {

    }
  }

  Future<void> signout({
    required BuildContext context
  }) async{
    await _auth.signOut();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => loginScreen()));
  }

}