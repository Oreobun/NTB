import 'package:sgparking/views/register.dart';
import 'package:sgparking/views/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView() {
    setState (() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    print(showSignIn);
    if (showSignIn == true){
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}