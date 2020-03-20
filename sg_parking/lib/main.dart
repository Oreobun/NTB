import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgparking/control/login.dart';
import 'package:sgparking/control/wrapper.dart';
import 'package:sgparking/views/maps.dart';
import 'control/auth.dart';
import 'entity/user.dart';
import 'views/home.dart';
import 'views/login_page.dart';
import 'views/registration_page.dart';
import 'views/email_verification_page.dart';



void main() => runApp(MyApp());

// useless text

//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'BottomNavigationBar',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: Home(),
//    );
//  }
//}
class MyApp extends StatelessWidget {



  @override
//  Widget build(BuildContext context) {
//    return StreamProvider<User>.value(
//      value: AuthService().user,
//      child: MaterialApp(
//        home: Wrapper(),
//      ),
//    );
//  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }

}

//class LoginPage extends StatefulWidget {
//  @override
//  _LoginPageState createState() => _LoginPageState();
//}
//
//class _LoginPageState extends State<LoginPage> {
//
//  // To adjust the layout according to the screen size
//  // so that our layout remains responsive ,we need to
//  // calculate the screen height
//  double screenHeight;
//
//  @override
//  Widget build(BuildContext context) {
//    screenHeight = MediaQuery.of(context).size.height;
//
//    return Scaffold(
//      body: SingleChildScrollView(
//        child: Stack(
//          children: <Widget>[
//            lowerHalf(context),
//            upperHalf(context),
//            loginCard(context)
//          ],
//        ),
//      ),
//    );
//  }
//
//
//
//  Widget upperHalf(BuildContext context) {
//    return Container(
//      height: screenHeight / 2,
//      child: Image.asset(
//        'assets/house.jpg',
//        fit: BoxFit.cover,
//      ),
//    );
//  }
//
//  Widget lowerHalf(BuildContext context) {
//    return Align(
//      alignment: Alignment.bottomCenter,
//      child: Container(
//        height: screenHeight / 2,
//        color: Color(0xFFECF0F3),
//      ),
//    );
//  }
//  Widget loginCard(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        Container(
//          margin: EdgeInsets.only(top: screenHeight / 4),
//          padding: EdgeInsets.only(left: 10, right: 10),
//          child: Card(
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(10),
//            ),
//            elevation: 8,
//            child: Padding(
//              padding: const EdgeInsets.all(30.0),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Align(
//                    alignment: Alignment.topLeft,
//                    child: Text(
//                      "Login",
//                      style: TextStyle(
//                        color: Colors.black,
//                        fontSize: 28,
//                        fontWeight: FontWeight.w600,
//                      ),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 15,
//                  ),
//                  TextFormField(
//                    decoration: InputDecoration(
//                        labelText: "Your Email", hasFloatingPlaceholder: true),
//                  ),
//                  SizedBox(
//                    height: 20,
//                  ),
//                  TextFormField(
//                    decoration: InputDecoration(
//                        labelText: "Password", hasFloatingPlaceholder: true),
//                  ),
//                  SizedBox(
//                    height: 20,
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      MaterialButton(
//                        onPressed: () {},
//                        child: Text("Forgot Password ?"),
//                      ),
//                      Expanded(
//                        child: Container(),
//                      ),
//                      FlatButton(
//                        child: Text("Login"),
//                        color: Color(0xFF4B9DFE),
//                        textColor: Colors.white,
//                        padding: EdgeInsets.only(
//                            left: 38, right: 38, top: 15, bottom: 15),
//                        shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(5)),
//                        onPressed: () {},
//                      )
//                    ],
//                  )
//                ],
//              ),
//            ),
//          ),
//        ),
//        Row(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            SizedBox(
//              height: 40,
//            ),
//            Text(
//              "Don't have an account ?",
//              style: TextStyle(color: Colors.grey),
//            ),
//            FlatButton(
//              onPressed: () {
//
//              },
//              textColor: Colors.black87,
//              child: Text("Create Account"),
//            )
//          ],
//        )
//      ],
//    );
//  }
//
//}
