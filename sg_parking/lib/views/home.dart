/*This class displays the home page of our application
* there is 3 tabs at the bottom of the page,
* switching between map view and list view*/


import 'package:flutter/material.dart';
import 'package:sgparking/views/contact_us_page.dart';
import 'package:sgparking/views/help_page.dart';
import 'tutorial_page.dart';
import 'search_display_page_list.dart';
import 'search_display_page_map.dart';
import 'maps.dart';
import 'report_page.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List _listPages = List();
  Widget _currentPage;

   List<String> _listTitle = ['Map', 'List View', 'Help Center'];

  void _openReportPage({BuildContext context, bool fullscreenDialog = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Report(),
      ),
    );
    // Navigator.pushNamed(context, '/about');
  }
  void _openTutorialPage ({BuildContext context, bool fullscreenDialog = false})
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Tutorial(),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    _listPages
      ..add(Maps())
      ..add(SearchMap())
      ..add(Help());
    _currentPage = Maps();
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
        title: Text(_listTitle[_currentIndex], style: TextStyle(
            color: Colors.white
        )),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context,false),
          child: Icon(
            Icons.backspace,  // add custom icons also
          ),
        ),
        automaticallyImplyLeading: true,

        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: <Widget>[
          if(_currentIndex == 0 || _currentIndex == 1)
            IconButton(
              tooltip: 'report',
              color: Colors.white,
              splashColor: Colors.redAccent,
              icon: Icon(Icons.warning),

              onPressed: () =>
                  _openReportPage(
                    context: context,
                    fullscreenDialog: true,
                  ),
            ),
          if(_currentIndex == 2)
            IconButton(
              tooltip: 'tutorial',
              color: Colors.white,
              splashColor: Colors.redAccent,
              icon: Icon(Icons.help),
              onPressed: () =>
                  _openTutorialPage(
                    context: context,
                    fullscreenDialog: true,
                  ),
            )
        ],

      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: _currentPage,
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Map'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('List View'),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            title: Text('Help'),
          ),
        ],
        onTap: (selectedIndex) => _changePage(selectedIndex),
      ),
    );
  }
}
