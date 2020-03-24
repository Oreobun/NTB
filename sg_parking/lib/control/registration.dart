/* This controller class is an abstraction of the registration functionality
from the views of the application. It authenticates the user account information
passed in through the login page and grants or denies access based on the account
availability in our Firebase database.
 */

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