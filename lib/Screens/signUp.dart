import 'package:flutter/material.dart';
import 'package:jereer_task/Screens/login.dart';
import 'package:jereer_task/auth/register.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forms and Validation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {






  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();



  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 50.0,
            horizontal: 10.0,
          ),
          child: _buildForm(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            debugPrint('All validations passed!!!');
          }
        },
        child: Icon(Icons.done),
      ),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _firstNameController,
              validator: (value)  {
                if (value!.isEmpty) {
                  return 'Username cannot be empty';
                } else if (value.length < 3) {
                  return 'Username must be at least 3 characters long.';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _lastNameController,
              validator: ( value) {
                if (value!.isEmpty) {
                  return 'Username cannot be empty';
                } else if (value.length < 3) {
                  return 'Username must be at least 3 characters long.';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextFormField(
          //     validator: (String value) {
          //       return null;
          //     },
          //     keyboardType: TextInputType.emailAddress,
          //     decoration: InputDecoration(
          //       labelText: 'License Issued By',
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(20.0)),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextFormField(
          //     validator: (String value) {
          //       return null;
          //     },
          //     keyboardType: TextInputType.emailAddress,
          //     decoration: InputDecoration(
          //       labelText: 'Driverer License Number',
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(20.0)),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailController,
              validator: ( value) {
                if (value!.isEmpty) return "email cannot be empty";

                }
                ,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'E-mail Address',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _addressController,
              validator: ( value) {
                if (value!.isEmpty) return ("address cannot be empty");
                bool mobileValid =
                RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value);
                return mobileValid ? null : "please enter valid mobile number";
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              validator: ( value) {
                if (value!.isEmpty) {
                  return 'Password cannot be empty';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters long.';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              controller: _confirmPasswordController,
              validator: ( value) {
                if (value != _passwordController.value.text) {
                  return 'Passwords do not match!';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              onPressed: () {
                String Name = '${_firstNameController.text}'+ ' '+'${_lastNameController.text}';
                Register.createUserWithEmailAndPassword(Name,_addressController.text,
                    _emailController.text, _confirmPasswordController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login()),
                );
              },
              child: const Text('Save', style: TextStyle(fontSize: 20)),
              color: Colors.blue,
              textColor: Colors.white,
              elevation: 5,
            ),
          )
        ],
      ),
    );
  }
}
