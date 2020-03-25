/*
This object class contains attributes of a user's feedback
 */

class FeedBack{
  String _name;
  String _email;
  String _contact;
  String _subject;
  String _description;


  FeedBack(this._name, this._email, this._contact, this._subject, this._description);

  //Maps feedback attributes to json format
  Map<String, dynamic> toJson() =>
      {
        'name': _name,
        'email': _email,
        'contact': _contact,
        'subject': _subject,
        'description': _description,
      };



}