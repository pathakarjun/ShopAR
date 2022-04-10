
class NewUser {
  late String uEmail;
  late String uPass;
  late String fName;
  late String lName;
  late String mailingAdd;
  late String phoneNum;

  // NewUser(String uEmail, String uPassword, String ufName, String ulName, String uMailing, String uPhone){
  //   this.email = uEmail;
  //   this.password = uPassword;
  //   this.fName = ufName;
  //   this.lName = ulName;
  //   this.mailingAdd = uMailing;
  //   this.phoneNum = uPhone;
  // };

  set email(String email){
    this.uEmail = email;
  }

  String get email => uEmail;

  set password(String password){
    this.uPass = password;
  }

  String get password => uPass;

// NewUser({this.email, this.password, this.fName, this.lName, this.mailingAdd, this.phoneNum});
}