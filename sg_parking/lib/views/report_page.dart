/*This class contains the interface for report functionality.
* User can send a report to the developers when he/she encounter a problems near a carpark such as:
* shelter collapse, gantry damaged, fallen tress, etc. Upon filling up the details of the report, user can send the information to the developers through
* send_email.dart. User must fill in all text fields before the report can be sent.  */
import 'package:flutter/material.dart';
import 'package:sgparking/control/send_email.dart';

class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Report';
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
              appTitle, style: TextStyle(
              color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.orange,

        ),
        body: MyCustomForm(),
      );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  SendEmail sendReport = new SendEmail();
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();
    final myController3 = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  height: 10
              ),
              Text(
                'Please further describe in detail opf the carpark of which you would like to report',
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
                controller: myController3,
                decoration: InputDecoration(
                    hintText: "Enter Name..",
                    hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize:  15),
                    hasFloatingPlaceholder: true,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please fill in your name';
                  }
                  return null;
                },
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
                controller: myController,
                maxLength: 100,
                maxLines: 2,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: "Enter a Subject..",
                  hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize:  15),
                  hasFloatingPlaceholder: true,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please fill in the subject';
                  }
                  return null;
                },
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
                controller: myController2,
                maxLength: 200,
                maxLines: null,
                minLines: 3,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: "Tell us more..",
                  hintStyle: TextStyle(
                      fontStyle: FontStyle.italic, fontSize: 15),
                  hasFloatingPlaceholder: true,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please fill in the description';
                  }
                  return null;
                },
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
          ),
        )
    );
  }
  void sendClicked(){
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a Snackbar.
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Email sent')));
      String subject = myController.text;
      String body = myController2.text;
      String name = myController3.text;
      sendReport.sendReportDetails(subject, body, name);
      Navigator.pop(context);
    }
  }
}