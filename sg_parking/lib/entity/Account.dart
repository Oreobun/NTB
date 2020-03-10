import 'package:flutter/cupertino.dart';

class Account{
  DateTime creationDate;
  Image profilePic;
  String accID;
  String email;
  DateTime getCreationDate(){
    return creationDate;
  }
  void setCreationDate(DateTime d){
    this.creationDate = d;
  }
  Image getProfilePic(){
    return profilePic;
  }
  void setProfilePic(Image i){
    this.profilePic = i;
  }
  String getAccID(){
    return getAccID();
  }
  void setAccID(String id){
    this.accID = id;
  }

}