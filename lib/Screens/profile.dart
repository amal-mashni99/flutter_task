import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jereer_task/Screens/Profile_widget.dart';
import 'package:path_provider/path_provider.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();


  late User user;
  late String img;

  @override
  void initState() {
    super.initState();


    user = FirebaseAuth.instance.currentUser;
    if (user.photoURL == null)
      img = 'https://picsum.photos/250?image=9';
    else
      img = user.photoURL;
if(user != null) {
  fName = TextEditingController(text: user.displayName.split(' ')[0]);
  lName = TextEditingController(text: user.displayName.split(' ')[1]);
  email = TextEditingController(text: user.email);
}
  }


  @override
  void dispose() {
    // TODO: implement dispose
    fName.dispose();
    lName.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: ,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ProfileWidget(

                imagePath: img,
                isEdit: true,
                onClicked: () async {
                  final image = await ImagePicker()
                      .getImage(source: ImageSource.gallery);

                  if (image == null) return;

                  final directory = await getApplicationDocumentsDirectory();
                  final name = image.path;
                  final imageFile = File('${directory.path}/$name');
                  final newImage =
                  await File(image.path).copy(imageFile.path);

                   //setState(() => user = user.copy(imagePath: newImage.path));
                },
              ),
              //VerticalDivider(),
              const SizedBox(height: 24,),

              SizedBox(height: 20,),
              Text(
                'First Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: fName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 1,
                // onChanged: widget.onChanged,
              ),
              SizedBox(height: 20,),
              Text(
                'Last Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: lName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 1,
                // onChanged: widget.onChanged,
              ),

              SizedBox(height: 20,),
              Text(
                'E-mail',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 1,
                // onChanged: widget.onChanged,
              ),



              Center(
                child: Container(
                  margin: EdgeInsets.all(25),
                  child: FlatButton(
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      String newName = '${fName.text}'+ ' '+'${lName.text}';
                      print (newName);
                      FirebaseFirestore.instance.collection('users').doc('${user.uid}').update({
                          'Name' : newName
                      });
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
