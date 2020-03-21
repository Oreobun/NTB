import 'package:flutter/material.dart';
import 'tutorial_page.dart';
import 'search_display_page_list.dart';
import 'search_display_page_map.dart';
import 'maps.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List _listPages = List();
  Widget _currentPage;



  @override
  void initState() {
    super.initState();

    _listPages
      ..add(Tutorial())
      ..add(GeoListenPage())
      ..add(SearchMap());
    _currentPage = GeoListenPage();
  }

  void _changePage(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
      _currentPage = _listPages[selectedIndex];
    });
  }
  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Maps()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SGParking'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: _currentPage,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red[600],
        child: Icon(Icons.location_on),
        onPressed: () {navigateToSubPage(context);},
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Tutorial'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('SearchList'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('SearchMap'),
          ),
        ],
        onTap: (selectedIndex) => _changePage(selectedIndex),
      ),
    );
  }
}
