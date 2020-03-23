import 'package:flutter/material.dart';
import 'package:sgparking/views/contact_us_page.dart';
import 'contact_us_page.dart';

class Help extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        'Frequently Asked Questions (FAQ)', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22)
                    )))
            ,
            SizedBox(
              height: 10,
            ),
            Container(
              height: screenHeight / 2.2,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) =>
                    EntryItem(data[index]),
                itemCount: data.length,
              ),
            ),


            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(children: <Widget>[
                Align(
                    alignment: Alignment.topLeft,
                    child:
                    Text(
                        'Contact Us', style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22)
                    )
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'If you have any other enquiries, comments or feedback, click the button below to contact us.'
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: FlatButton(
                      color: Color(0xFF4B9DFE),
                      textColor: Colors.white,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Text("Contact Us"),
                      onPressed: () {
                        contactUsClicked(context);
                      },
                    )
                ),

              ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future contactUsClicked(context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactUs()),
    );
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

final List<Entry> data = <Entry>[
  Entry(
    '1. Where can I find the tutorial page',
    <Entry>[
      Entry(
        'The tutorial page can be found at blahblahablha',
      ),
    ],
  ),
  Entry(
    '2. How can I report a carpark for wrong information given?',
    <Entry>[
      Entry('The report button of a carpark can be found next to the name of the carpark next to the list view tab'),
    ],
  ),
  Entry(
    '3. My GPS is not pointing me to my current location, what can i do to fix it?)',
    <Entry>[
      Entry('Try restarting your the application. If that does not help, enable and disable location services.'
      )
    ],
  ),
  Entry(
    '3. My GPS is not pointing me to my current location, what can i do to fix it?)',
    <Entry>[
      Entry('Try restarting your the application. If that does not help, enable and disable location services.'
      )
    ],
  ),
  Entry(
    '3. My GPS is not pointing me to my current location, what can i do to fix it?)',
    <Entry>[
      Entry('Try restarting your the application. If that does not help, enable and disable location services.'
      )
    ],
  ),
  Entry(
    '3. My GPS is not pointing me to my current location, what can i do to fix it?)',
    <Entry>[
      Entry('Try restarting your the application. If that does not help, enable and disable location services.'
      )
    ],
  ),


];



// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}