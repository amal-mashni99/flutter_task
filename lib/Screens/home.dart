
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jereer_task/Screens/profile.dart';
import 'package:jereer_task/Screens/setting.dart';

class Home extends StatefulWidget {



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late String name;
  @override
  void initState() {
    super.initState();


    if( FirebaseAuth.instance.currentUser.displayName != null)
      name = FirebaseAuth.instance.currentUser.displayName;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
      body: Container(
       color: Colors.white54,
        child: Container(

          child: Column(children: <Widget>[
            SizedBox(
              height: 100,
              width: double.infinity,
            ),
            SizedBox(
              width: 330,
              height: 120,
              child: Container(

                color: Colors.blue,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(18),
                      child: Center(
                        child: Text(

                          'WELCOME '+ '${name}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

//////////////////////


class NavButtom extends StatefulWidget {

  

  @override
  _NavButtomState createState() => _NavButtomState();
}

class _NavButtomState extends State<NavButtom> {
  int index = 0;
  final List<Widget> tabs = [Home(),Profile(),Setting()];


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

