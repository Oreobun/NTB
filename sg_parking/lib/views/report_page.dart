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
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            //`true` if you want Flutter to automatically add Back Button when needed,
            //or `false` if you want to force your own back button every where
            title: Text(appTitle),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            )


        ),
        body: MyCustomForm(),
      ),
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: myController3,
            decoration: InputDecoration(
                labelText: 'Name'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please fill in your name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: myController,
            decoration: InputDecoration(
                labelText: 'Subject'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please fill in the subject';
              }
              return null;
            },
          ),
          TextFormField(
            controller: myController2,
            decoration: InputDecoration(
                labelText: 'Body'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please fill in the body';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Email sent')));
                  String subject = myController.text;
                  String body = myController2.text;
                  String name = myController3.text;
                  sendReport.sendReportDetails(subject,body,name);
                }
              },
              child: Text('Send email'),
            ),
          ),
        ],
      ),
    );
  }
}