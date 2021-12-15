import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jereer_task/models/customer.dart';

class Register {
  static Future<void> createUserWithEmailAndPassword(String name,String address,
      String email, String password) async {
    print("createUserWithEmailAndPassword");
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      //     verificationId: phoneNumber, smsCode: "xxxx");
      // userCredential.user.updatePhoneNumber(phoneAuthCredential);
      print("userid " + userCredential.user.uid);
      if (userCredential.user.uid != null) {
        var user = userCredential.user;
        await FirebaseFirestore.instance.collection('users').doc('${user.uid}').set({
          'displayName' : name,
          'address':address,
          'email': user.email,
          'photoURL':'https://picsum.photos/250?image=9'

        });


      }
      print("regestraion is succesfull");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> addUser(Customer user) async {
    print("addUser");
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc('${user.uId}').set(user.toJson());

  }
}
