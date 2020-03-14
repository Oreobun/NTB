class User{
  String gender;
  DateTime dateOfBirth;
  String firstname;
  String lastname;
  static int numberOfUsers;
  User.empty(){
    numberOfUsers++;
  }
  User(String g, DateTime d, String f, String l){
    this.gender = g;
    this.dateOfBirth = d;
    this.firstname = f;
    this.lastname = l;
    numberOfUsers++;
  }
  String getGender() {
    return gender;
  }
  void setGender(String gender){
    this.gender = gender;
  }
  DateTime getDOB(){
    return dateOfBirth;
  }
  void setDOB(DateTime DOB){
    this.dateOfBirth = DOB;
  }
  String getFirstName(){
    return firstname;
  }
  void setFirstName(String first){
    this.firstname = first;
  }
  String getLastName(){
    return lastname;
  }
  void setLastName(String last){
    this.lastname = last;
  }
}