import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';



import '../custom widgets/models/users/user.dart';

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final CollectionReference _usersFireStore =
  FirebaseFirestore.instance.collection('users');

  static Future createUserEmailAndPassword(
      String email, String password, AppUser user) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _usersFireStore.doc(_auth.currentUser!.uid).set({
        'name': user.name,
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

  static Future signIn(
      String email,
      String password,
      ) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on Exception catch (e) {
      print("services/firebase_services, signIn $e");
    }
  }

  static Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("services/firebase_services, signOut $e");
    }
  }
}

class Storage {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Reference storageRef = FirebaseStorage.instance.ref();
  static final CollectionReference _usersFireStore =
  FirebaseFirestore.instance.collection('users');

  static Future uploadImage(File? image) async {
    final imageReference = storageRef.child(_auth.currentUser!.uid);
    if(kIsWeb){
      try {
        PickedFile localFile = PickedFile(image!.path);
        Uint8List bytes = await localFile.readAsBytes();
        await imageReference.putData(bytes);
        final imageURL = await imageReference.getDownloadURL();
        await _usersFireStore
            .doc(_auth.currentUser!.uid)
            .update({'imageUrl': imageURL});
      } on Exception catch (e) {
        print("services/firebase_services, uploadImage (WEB) $e");
      }
    }else{
      try {

        await imageReference.putFile(image!);
        final imageURL = await imageReference.getDownloadURL();
        //upload image into the user's document
        await _usersFireStore
            .doc(_auth.currentUser!.uid)
            .update({'imageUrl': imageURL});
      } on Exception catch (e) {
        // TODO
        print("services/firebase_services, uploadImage $e");
      }
    }

  }
}
