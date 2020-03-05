import 'package:flutter/material.dart';

class SearchMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.map,
          size: 120.0,
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}