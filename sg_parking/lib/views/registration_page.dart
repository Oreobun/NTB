/*This class contains the interface for registration functionality.
* User can create a account in this page and the account information will be stored in our fire base
* data base. User can navigate here from the login_page and navigate back to the login_page  */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sgparking/control/auth.dart';
import 'package:sgparking/views/email_verification_page.dart';
import 'home.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';
  String password2 = '';


  // To adjust the layout according to the screen size
  // so that our layout remains responsive ,we need to
  // calculate the screen height
  double screenHeight;
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();
    myController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            lowerHalf(context),
            upperHalf(context),
            loginCard(context)
          ],
        ),
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset(
        'assets/house.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight / 2,
        color: Color(0xFFECF0F3),
      ),
    );
  }

  Widget loginCard(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: screenHeight / 4),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: myController,
                      validator: (val) => val.isEmpty ? "Enter an email" : null,
                      decoration: InputDecoration(
                          labelText: "Your Email", hasFloatingPlaceholder: true),
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: myController2,
                      validator: (val) => val.isEmpty ? "Enter an password" : null,
                      decoration: InputDecoration(
                          labelText: "Your password", hasFloatingPlaceholder: true),
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: myController3,
                      validator: (val) => val.isEmpty ? "Re-enter password" : null,
                      decoration: InputDecoration(
                          labelText: "Your password", hasFloatingPlaceholder: true),
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton(
                          child: Text("Go back"),
                          color: Color(0xFF4B9DFE),
                          textColor: Colors.white,
                          padding: EdgeInsets.only(
                              left: 38, right: 38, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: (){}
                        ),

                        FlatButton(
                          child: Text("Create"),
                          color: Color(0xFF4B9DFE),
                          textColor: Colors.white,
                          padding: EdgeInsets.only(
                              left: 38, right: 38, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () async {
                            email = myController.text;
                            password = myController2.text;
                            password2 = myController3.text;
                            // checking re-enter password matches with password


                            print(email);
                            print(password);
                            // making sure parameters for registering accounts correct, eg email have @xyz.com and not @xyz.c using _formKe
                            if (_formKey.currentState.validate()) {
                              dynamic result = await _auth
                                  .registerWithEmailAndPassword(email, password);
                              if (password != password2) {
                                setState(() =>
                                error =
                                'Password does not match, please re-enter');
                              }
                              else if (result == null) {
                                setState(() => error = "Email is already in use or invalid");
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      Home(
                                        // TODO do email verification via google maybe
//                            MaterialPageRoute(builder: (context) => EmailVerificationPage(
                                      )),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 12.0),
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future createAccountClicked() async {
    String email = myController.text;
    String password = myController2.text;
    String password2 = myController3.text;


    //insert logic to check database here



    // use basic email verification from auth from firebase first, add in signing in from google etc in the future
//      Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => EmailVerificationPage(
//        )),
//      );

  }
}
