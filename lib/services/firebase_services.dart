import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../custom widgets/models/users/user.dart';

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final CollectionReference _usersFireStore = FirebaseFirestore.instance.collection('users');

  static void createUserEmailAndPassword(String email, String password, AppUser user) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _usersFireStore.doc(_auth.currentUser!.uid).set({
        'name':user.name,
        'position': user.position,
        'uid': _auth.currentUser!.uid,
        //TODO: ADD OTHER FIELDS
      });
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print("services/firebase_services, createUserEmailAndPassword $e");
    }
  }

  static void signIn(String email, String password,)async{

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on Exception catch (e) {
      print("services/firebase_services, signIn $e");
    }

  }

  static void signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("services/firebase_services, signOut $e");
    }
  }
}
