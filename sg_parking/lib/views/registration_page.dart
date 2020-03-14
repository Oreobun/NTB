import 'package:flutter/material.dart';
import 'package:sgparking/views/email_verification_page.dart';
import 'home.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // To adjust the layout according to the screen size
  // so that our layout remains responsive ,we need to
  // calculate the screen height
  double screenHeight;
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();
    myController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            lowerHalf(context),
            upperHalf(context),
            loginCard(context)
          ],
        ),
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset(
        'assets/house.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight / 2,
        color: Color(0xFFECF0F3),
      ),
    );
  }

  Widget loginCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 4),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: myController,
                    decoration: InputDecoration(
                        labelText: "Enter Email", hasFloatingPlaceholder: true),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: myController2,
                    decoration: InputDecoration(
                        labelText: "Enter Password", hasFloatingPlaceholder: true),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: myController3,
                    decoration: InputDecoration(
                        labelText: "Re-enter Password", hasFloatingPlaceholder: true),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FlatButton(
                      child: Text("Create"),
                      color: Color(0xFF4B9DFE),
                      textColor: Colors.white,
                      padding: EdgeInsets.only(
                          left: 38, right: 38, top: 15, bottom: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: createAccountClicked
                  )
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

  void createAccountClicked() {
    String email = myController.text;
    var password = myController2.text;
    var password2 = myController3.text;
    print(email);
    print(password);
    print(password2);
    //insert logic to check database here
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmailVerificationPage(
        )),
      );

  }
}
