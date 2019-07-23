class Users {

  int _id;
  String _name;
  String _username;
  String _password;

  Users(this._name, this._username, this._password);
  Users.withId(this._id, this._name, this._username, this._password);  

  int get id => _id;
  String get name => _name;
  String get username => _username;
  String get password => _password;

  set name(String strName){
    if(strName.length <= 255){
      this._name=strName;
    }
  }

  set username(String strUsername){
    if(strUsername.length <= 255){
      this._username=strUsername;
    }
  }

  set password(String strPassword){
    if(strPassword.length <= 10){
      this._password=strPassword;
    }
  }

  //allow to convert User object to Map Object
  Map<String, dynamic> toMap(){

    var map=Map<String, dynamic> ();
    if(id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['username'] = _username;
    map['password'] = _password;

    return map;
  }

  //Extract a Note Object from a Map Object
  Users.fromMapObject(Map<String, dynamic> map){
    this._id=map['id'];
    this._name=map['name'];
    this._username=map['username'];
    this._password=map['password'];
  }


}