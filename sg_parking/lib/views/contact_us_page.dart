import 'package:flutter/material.dart';
import 'package:sgparking/entity/feedback.dart';
import 'package:sgparking/control/send_feedback.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUs> {
  @override
  final nameText = TextEditingController();
  final emailText = TextEditingController();
  final contactText = TextEditingController();
  final subjectText = TextEditingController();
  final descriptionText = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameText.dispose();
    emailText.dispose();
    contactText.dispose();
    subjectText.dispose();
    descriptionText.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text('Help Center', style: TextStyle(
              color: Colors.white
          )),

          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                        'Contact Us', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22)
                    ),
                    SizedBox(
                        height: 10
                    ),
                    Text(
                      'Please enter your personal particulars and your enquries below',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                        height: 20
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)
                      ),
                    ),

                    TextFormField(
                      controller: nameText,
                      decoration: InputDecoration(
                          hintText: "Enter Name..",
                          hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize:  15),
                          hasFloatingPlaceholder: true),
                    ),
                    SizedBox(
                        height: 20
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)
                      ),
                    ),
                    TextFormField(
                      controller: emailText,
                      decoration: InputDecoration(
                          hintText: "Enter Email..",
                          hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize:  15),
                          hasFloatingPlaceholder: true),
                    ),
                    SizedBox(
                        height: 20
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'Contact',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)
                      ),
                    ),
                    TextFormField(
                      controller: contactText,
                      decoration: InputDecoration(
                          hintText: "Enter Contact Number..",
                          hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize:  15),
                          hasFloatingPlaceholder: true),
                    ),
                    SizedBox(
                        height: 20
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'Subject',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)
                      ),
                    ),
                    TextFormField(
                      controller: subjectText,
                      maxLength: 100,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          hintText: "Enter a Subject..",
                          hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize:  15),
                          hasFloatingPlaceholder: true),
                    ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          'Description',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)
                      ),
                    ),
                    TextFormField(
                      controller: descriptionText,
                      maxLength: 200,
                      maxLines: null,
                      minLines: 3,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          hintText: "Tell us more..",
                          hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize:  15),
                          hasFloatingPlaceholder: true
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: FlatButton(
                        child: Text("Send"),
                        color: Color(0xFF4B9DFE),
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            sendClicked();
                          }
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ))
        )
    );
  }

  void sendClicked(){
    SendFeedBack sendFeedBack = new SendFeedBack();
    sendFeedBack.sendFeedBack(nameText.text, emailText.text, contactText.text, subjectText.text, descriptionText.text);
    Navigator.pop(
      context);
  }
}