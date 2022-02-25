class User {
  String _email;

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String _username;

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String _id;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  User.fromMap(Map<String, dynamic> data) {
    _id = data["id"];
    _username = data["username"];
    _email = data["email"];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'username': _username,
      'email': _email,
    };
  }

  User(
    this._username,
    this._email,
  );
}
