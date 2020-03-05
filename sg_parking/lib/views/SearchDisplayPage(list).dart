import 'dart:async';
import 'dart:convert';
import 'package:sgparking/entity/Carpark.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Response> fetchResponse() async {
  final response =
  await http.get('https://api.data.gov.sg/v1/transport/carpark-availability');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return Response.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
  }
}


void main() => runApp(App());

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<App> {
  Future<Response> futureResponse;



  @override
  void initState() {
    super.initState();
    futureResponse = fetchResponse();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Carpark Search'),
        ),
        body: Center(
          child: FutureBuilder<Response>(
            future: futureResponse,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.items[0].carparkData[0].carparkInfo[0].totalLots);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}