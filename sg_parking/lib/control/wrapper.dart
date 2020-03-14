import 'package:sgparking/views/Authenticate.dart';
import 'package:sgparking/views/Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgparking/entity/User.dart';

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
