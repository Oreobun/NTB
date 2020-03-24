/*
This object class contains attributes of a user's history
 */

class History{
  DateTime timeStamp;
  String pageAccess;
  DateTime getTime(){
    return timeStamp;
  }
  void setTime(DateTime t){
    this.timeStamp = t;
  }
  String getPageAccess(){
    return pageAccess;
  }
  void setPageAccess(String p){
    this.pageAccess = p;
  }
  String load(){
    return "loaded successfully";
  }
}