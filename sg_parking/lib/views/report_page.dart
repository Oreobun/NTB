import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Report extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new RaisedButton(onPressed: () => _launchURL('zzk1996zzk1996gmail.com', 'Flutter Email Test', 'Hello Flutter'), child: new Text('Send mail'),),
      ),
    );
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}