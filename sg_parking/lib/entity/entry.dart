/*
This object class contains attributes of an entry in a list found in the help page
 */

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}