/* This controller class is a wrapper class that provides a control flow between
a successful login attempt that brings the home page, or a denied attempt that re-prompts
sign in
 */

import 'package:sgparking/views/sign_in.dart';
import 'package:sgparking/views/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgparking/entity/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);


    // return either Home or Sign In widget
    if (user == null) {
      return SignIn();
    } else {
      return Home();
    }
  }
}
