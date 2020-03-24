/*A controller class that allows contact_us to store feedback in the database.
Developers can go through the feedback by accessing the database*/

import 'package:http/http.dart';
import 'package:sgparking/entity/feedback.dart';
import 'dart:convert';

class SendFeedBack {

  void sendFeedBack(String name, String email, String contact, String subject, String description) {
    FeedBack feedBack = new FeedBack(name, email, contact, subject, description);
    final String url = 'http://ntb-rest-api.us-east-2.elasticbeanstalk.com/api/add_feedback';

    String json = jsonEncode(feedBack);
    _makePostRequest(url, json);
  }
  Future _makePostRequest(String url, String json) async {
    // set up POST request arguments

    Map<String, String> headers = {"Content-type": "application/json"};

    // make POST request
    Response response = await post(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    String body = response.body;
    print(body);
  }
}