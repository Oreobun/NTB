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
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You will never be satisfied.'),
                Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Regret'),
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