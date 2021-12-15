
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jereer_task/models/job.dart';



class MyHome extends StatefulWidget {

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  List<Job> jobs = [
    Job(title: 'title', employer: 'employer', salaryMin: 1000, salaryMax: 1200,Location: 'Ramallah'),
    Job(title: 'title', employer: 'employer', salaryMin: 1000, salaryMax: 1200,Location: 'Ramallah'),
    Job(title: 'title', employer: 'employer', salaryMin: 1000, salaryMax: 1200,Location: 'Ramallah'),
    Job(title: 'title', employer: 'employer', salaryMin: 1000, salaryMax: 1200,Location: 'Ramallah'),
    Job(title: 'title', employer: 'employer', salaryMin: 1000, salaryMax: 1200,Location: 'Ramallah'),
    Job(title: 'title', employer: 'employer', salaryMin: 1000, salaryMax: 1200,Location: 'Ramallah'),
    Job(title: 'title', employer: 'employer', salaryMin: 1000, salaryMax: 1200,Location: 'Ramallah'),

  ];

  Widget personDetailCard(Job) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(Job.title,style: TextStyle(color: Colors.white,fontSize: 17)),
                   ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(Job.employer,
                    style: TextStyle (
                        color: Colors.white,
                        fontSize: 18
                    ),
                  ),
                  Text(Job.Location,
                    style: TextStyle (
                        color: Colors.white,
                        fontSize: 16
                    ),
                  ),
                  Text('${Job.salaryMin}'' - '+'${Job.salaryMax}',
                    style: TextStyle (
                        color: Colors.white,
                        fontSize: 15
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  final salary = TextEditingController();
  late User user;
  late String name;
  final _formKey = GlobalKey<FormState>();
  String selected='';
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
        new AlertDialog(
          content: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.close),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: new DropdownButtonFormField<String>(

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Preferred Job",
                          // fillColor: Colors.white,
                        ),

                        items: <String>['Backend Developer','Frontend Developer','Mobile', 'DevOps', ].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => selected = value!);
                        },

                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        controller: salary,
                        validator: ( value) {
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Preferred Salary',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                    ),
                    Padding(

                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 10),),
                        onPressed: () {
                          print (selected);
                          FirebaseFirestore.instance.collection('users').doc('${user.uid}').update({
                            'Salary' : salary.text,
                            'Job': selected
                          });

                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
          child: Column(
            children: <Widget>[
            SizedBox(height: 30,),
              Column(
                  children: jobs.map((p) {
                    return personDetailCard(p);
                  }).toList()
              )
            ],
          ),
        ),
      ),
    );
  }
}