import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:jereer_task/auth/google.dart';
import 'package:jereer_task/auth/signin.dart';

import 'home.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  String sEmail = '';
  String password = '';
  String logInError = '';

  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // String logInError = "";
    logInError = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 140,
              child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontFamily: 'Raleway'),
                  )),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(160),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                        Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey))),
                                    child: TextFormField(
                                        controller: email,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[700])),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'email cannot be empty';
                                          }
                                          if (RegExp(
                                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                              .hasMatch(value)) {
                                            return 'Please enter a valid Email';
                                          }
                                          return null;
                                        }),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: pass,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[700])),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Password cannot be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(logInError),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Colors.blue,
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ])),
                              child: Center(
                                  child: FlatButton(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,fontSize: 15),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          sEmail = email.text;
                                          password = pass.text;
                                        });
                                        String error =
                                        await Signin.signInWithEmailAndPassword(
                                            sEmail, password);
                                        String uId = "";
                                        print(
                                            "error.substring(0, 7) ${error.substring(0, 7)}");
                                        if (error.substring(0, 7) == "success") {
                                          uId = error.split(" ")[1];
                                          error = "success";
                                          print("succes $uId");
                                          // MySecureStorage.writeSecureData(
                                          //     "uId", uId);
                                          print("uid in secureData");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => NavButtom()),
                                          );
                                          print("success");
                                        } else {
                                          setState(() {
                                            logInError = error;
                                          });
                                        }
                                      }
                                    },
                                  )
                                //  Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            ),
                            SizedBox(height: 25,),

                            Container(
                              width: 300,
                              height: 40,
                              child: SignInButton(

                                Buttons.Google,
                                text: "Sign up with Google",
                                onPressed: () {
                                  signInWithGoogle().then((onValue) {


                                  }).catchError((e) {
                                    print(e);
                                  }).then((onValue) {

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NavButtom()),
                                    );
                                  });
                                },
                              ),
                            )


                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
