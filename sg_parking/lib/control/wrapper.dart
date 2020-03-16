import 'package:sgparking/views/authenticate.dart';
import 'package:sgparking/views/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgparking/entity/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);


    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
