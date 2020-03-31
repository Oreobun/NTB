/*This class contains the interface for our tutorial function.
* Images that demonstrate the user of our SGParking app will be shown here.
* They will be shown is sequence and user can forward/backward using swipe motions */

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Tutorial extends StatefulWidget
{
  Tutorial() : super();
  TutorialState createState() => TutorialState();
}

class TutorialState extends State<Tutorial> {

  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    'assets/Tutorial1.jpg',
    'assets/Tutorial2.jpg',
    'assets/Tutorial3.jpg',
    'assets/Tutorial4.jpg',
    'assets/Tutorial5.jpg',
    'assets/Tutorial6.jpg',
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
            'Tutorial', style: TextStyle(
            color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            carouselSlider = CarouselSlider(
              height: screenHeight/1.3,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: false,
              reverse: false,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
              items: imgList.map((imgUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.green,
                        ),
                        child: Image.asset(
                          imgUrl,
                          fit: BoxFit.fill,
                        ),
                      );
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(imgList, (index, url) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.redAccent : Colors.green,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  goToPrevious() {
    carouselSlider.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  goToNext() {
    carouselSlider.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.decelerate);
  }
}
