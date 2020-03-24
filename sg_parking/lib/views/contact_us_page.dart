import 'package:flutter/material.dart';
import 'package:sgparking/views/help_page.dart';
import 'home.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUs> {
  @override
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  String name = '';
  String contact = '';
  String subject = '';
  String description = '';

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Help Center', style: TextStyle(
              color: Colors.black
          )),
          centerTitle: true,
          backgroundColor: Colors.white,
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
                      controller: myController,
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
                          'Contact',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)
                      ),
                    ),
                    TextFormField(
                      controller: myController2,
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
                      controller: myController3,
                      decoration: InputDecoration(
                          hintText: "Enter subject of the matter..",
                          hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize:  15),
                          hasFloatingPlaceholder: true),
                    ),
                    SizedBox(
                        height: 20
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
                      controller: myController4,
                      maxLength: 200,
                      maxLines: null,
                      minLines: 3,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          hintText: "Tell us more..",
                          hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize:  15),
                          hasFloatingPlaceholder: true),
                    ),
                    SizedBox(
                        height: 20
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
                    )
                  ],
                ))
        )
    );
  }

  void sendClicked(){
    this.name = myController.text;
    this.contact = myController2.text;
    this.subject = myController3.text;
    this.description = myController4.text;
    Navigator.pop(
      context);
  }
}