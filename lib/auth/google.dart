import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _db = FirebaseFirestore.instance;
final googleSignIn = GoogleSignIn();


String name = '';
String email='';
String image='';
Future <String> signInWithGoogle() async{

 final googleSignInAccount = await googleSignIn.signIn();


  final  googleSignInAuthentication = await googleSignInAccount.authentication;
  final credential = GoogleAuthProvider.credential( accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken);

  final auth = await _auth.signInWithCredential(credential);
  final user= auth.user;
 print("userid " + user.uid);
 print("useridnae " + user.displayName);
 print("useridimage " + user.photoURL);
 print("userid " );


 await FirebaseFirestore.instance.collection('users').doc('${user.uid}').set({
   'Name' : user.displayName,
   'Email': user.email,
   'Photo' : user.photoURL,
  });


  final current = await _auth.currentUser!;
  assert (current.uid == user.uid);



  return 'signInWithGoogleDone: $user';





}













