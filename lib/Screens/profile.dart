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

 // late File image;
  String imgUrl='';
  TextEditingController img = TextEditingController();

  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController job = TextEditingController();
  TextEditingController salary = TextEditingController();
  String Img='';



  late User user;

  @override
  void initState()  {



    user = FirebaseAuth.instance.currentUser;

String Fname ='' ;
String Lname = '';
String Email='';
String Address='';
String Job='';
String Salary='';

if(user != null) {

  FirebaseFirestore.instance.collection('users').doc('${user.uid}').get().then((value) =>
      setState(() {
        fName = TextEditingController(text: value.get('displayName').toString().split(' ')[0]);
        Img =  value.get('photoURL').toString();

       lName = TextEditingController(text: value.get('displayName').toString().split(' ')[1]);
       email = TextEditingController(text: value.get('email').toString());
       job = TextEditingController(text: value.get('Job').toString());
       salary = TextEditingController(text: value.get('Salary').toString());
       address = TextEditingController(text: value.get('address').toString());


      }),
  // print( value.get('displayName').toString())
  //fName = TextEditingController(text: value.get('displayName').toString())

  );

print(Fname + "amallll");





}

    super.initState();
  }



  @override
  void dispose() {
    // TODO: implement dispose
    fName.dispose();
    lName.dispose();
    email.dispose();
    job.dispose();
    salary.dispose();
    address.dispose();
    super.dispose();
  }
  // Future getImage ()
  // async {
  //   var img = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     image= img;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            ProfileWidget(

            imagePath: Img,
            isEdit: true,
            onClicked: () async {
              final image = await ImagePicker()
                  .getImage(source: ImageSource.gallery);

              if (image == null) return;

              final directory = await getApplicationDocumentsDirectory();
              final name = image.path;
              print ("image  "+ name);
              final imageFile = File('${directory.path}/$name');
              final newImage =
              await File(image.path).copy(imageFile.path);

            //  setState(() => user = user.copy(imagePath: newImage.path));
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
              SizedBox(height: 20,),
              Text(
                'Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: address,
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
                'Preferred Job',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: job,
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
                'Preferred Salary',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: salary,
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
