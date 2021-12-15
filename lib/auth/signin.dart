import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jereer_task/services/secure_storage_service.dart';


class Signin {
  static Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    print("signInWithEmailAndPassword()");
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String uid = "";
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        MySecureStorage mss = MySecureStorage();

        MySecureStorage.writeSecureData(value.user.uid, value.user.email);
        print("the user data from firestore after login " +
            users.doc(value.user.uid).toString());
        uid = value.user.uid;
         return value;
      });
      return ("success $uid");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
      return e.code;
    }
  }


}
