

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jereer_task/Screens/login.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      if(FirebaseAuth.instance.currentUser != null){
        // wrong call in wrong place!
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => NavButtom()
        ));
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Login()
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
children: [
  Container(
    height: 90.0,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage('assets/cloud.png'), fit: BoxFit.contain,),
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  ),
Text("Jereer",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold,color: Colors.white),)
],
        ),
      ),
    );
  }
}
