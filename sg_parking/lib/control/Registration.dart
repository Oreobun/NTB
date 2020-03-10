class Registration{
  String ID;
  String password;
  String getID(){
    return ID;
  }
  void setID(String s){
    this.ID = s;
  }
  String getPW(){
    return password;
  }
  void setPW(String pw){
    this.password = pw;
  }
  bool checkExisting(){
    return true;
  }
}