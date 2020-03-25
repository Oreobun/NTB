/*This class  displays a pop up to ask user to turn
on loaction services if location services is not turned on*/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';

class GpsValidation {

  Future<void> gpsDialog() async {
    return showDialog<void>(
//      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('fill in sth here'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('continue'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Future<bool> gpsValidation()async{
    final GeolocationResult result =  await Geolocation.isLocationOperational();

    if(result.isSuccessful) {
      return true;
    } else {
      return false;
    }
  }
}