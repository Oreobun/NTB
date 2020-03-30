import 'package:flutter/material.dart';
import 'package:sgparking/views/contact_us_page.dart';
import 'contact_us_page.dart';
import 'package:sgparking/entity/entry.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
                'Frequently Asked Questions (FAQ)', style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22)
            ),

            SizedBox(
              height: 10,
            ),
            Text(
              'Some commonly asked questions by our users',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Colors.grey),
              textAlign: TextAlign.center,
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
              height: 40,
            ),
            Text(
                'Contact Us', style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22)
            ),

            SizedBox(
              height: 10,
            ),
            Text(
              'If you have any other enquiries, please feel free to contact us by clicking the button below',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
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
            ),
            SizedBox(
              height: 20,
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



final List<Entry> data = <Entry>[
  Entry(
    '1. Where can I find the tutorial page',
    <Entry>[
      Entry(
        'The tutorial page is shown after registering an account. You can also find it in this tab at the bottom.',
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
    '4. How can I search for a carpark around a specific area?',
    <Entry>[
      Entry('You can do so by navigating the map to the area and carparks in the view will be shown'
      )
    ],
  ),
  Entry(
    '5. How can I find out more details about a carpark?',
    <Entry>[
      Entry('More information on a carpark can be seen when you select on it.',
      )
    ],
  ),
  Entry(
    '6. Where can I feedback to the devs about a certain concern I have?',
    <Entry>[
      Entry('You can reach the dev team by tapping on the Contact Us button found below on this page.'
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