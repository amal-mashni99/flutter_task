
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jereer_task/Screens/profile.dart';
import 'package:jereer_task/Screens/setting.dart';
import 'package:jereer_task/Screens/test.dart';

// class Home extends StatefulWidget {
//
//
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   final salary = TextEditingController();
//   late User user;
//   late String name;
//   final _formKey = GlobalKey<FormState>();
//    String selected='';
//   @override
//   void initState() {
//      user = FirebaseAuth.instance.currentUser;
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((_) async {
//       await showDialog<String>(
//         context: context,
//           builder: (BuildContext context) =>
//             new AlertDialog(
//               content: Stack(
//                 overflow: Overflow.visible,
//                 children: <Widget>[
//                   Positioned(
//                     right: -40.0,
//                     top: -40.0,
//                     child: InkResponse(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: CircleAvatar(
//                         child: Icon(Icons.close),
//                         backgroundColor: Colors.red,
//                       ),
//                     ),
//                   ),
//                   Form(
//                     key: _formKey,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: new DropdownButtonFormField<String>(
//
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderRadius: const BorderRadius.all(
//                                   const Radius.circular(20.0),
//                                 ),
//                               ),
//                               filled: true,
//                               hintStyle: TextStyle(color: Colors.grey[800]),
//                               hintText: "Preferred Job",
//                               // fillColor: Colors.white,
//                             ),
//
//                             items: <String>['Backend Developer','Frontend Developer','Mobile', 'DevOps', ].map((String value) {
//                               return new DropdownMenuItem<String>(
//                                 value: value,
//                                 child: new Text(value),
//                               );
//                             }).toList(),
//                             onChanged: (value) {
//                               setState(() => selected = value!);
//                             },
//
//                           ),
//
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: TextFormField(
//                             controller: salary,
//                             validator: ( value) {
//                               return null;
//                             },
//                             keyboardType: TextInputType.phone,
//                             decoration: InputDecoration(
//                               labelText: 'Preferred Salary',
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20.0)),
//                             ),
//                           ),
//                         ),
//                         Padding(
//
//                           padding: const EdgeInsets.all(8.0),
//                           child: RaisedButton(
//                             color: Colors.blue,
//                             child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 10),),
//                             onPressed: () {
// print (selected);
// FirebaseFirestore.instance.collection('users').doc('${user.uid}').update({
//   'Salary' : salary.text,
//   'Job': selected
// });
//
// Navigator.of(context).pop();
//                             },
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//       );
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(),
//       body: Container(
//        color: Colors.white54,
//         child: Container(
//
//           child: Column(children: <Widget>[
//             SizedBox(
//               height: 100,
//               width: double.infinity,
//             ),
//             SizedBox(
//               width: 330,
//               height: 120,
//               child: Container(
//
//                 color: Colors.blue,
//                 child: Column(
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.all(18),
//                       child: Center(
//                         child: Text(
//
//                           'WELCOME ',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 25,
//                               color: Colors.white),
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }

//////////////////////


class NavButtom extends StatefulWidget {

  

  @override
  _NavButtomState createState() => _NavButtomState();
}

class _NavButtomState extends State<NavButtom> {
  int index = 0;
  final List<Widget> tabs = [MyHome(),Profile(),MyHomePage()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,

        type: BottomNavigationBarType.fixed,
        // iconSize: 30,
        //  selectedFontSize: 18,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            // ignore: deprecated_member_use
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            // ignore: deprecated_member_use
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
          ),

          BottomNavigationBarItem(
              icon: new Icon(Icons.settings, color: Colors.white),
              // ignore: deprecated_member_use
              title: new Text(
                'Setting',
                style: TextStyle(color: Colors.white),
              ))
        ],
        onTap: (indexX) {
          setState(() {
            index = indexX;
          });
        },
      ),
    );
  }
}

