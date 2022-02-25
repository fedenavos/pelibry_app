import "dart:collection";
import 'package:flutter/foundation.dart';
import 'user.dart';

class UserData extends ChangeNotifier {
  List<User> _users = [];
  User _currentUser;

  void addUser(User newUser) {
    _users.add(newUser);
    notifyListeners();
  }

  UnmodifiableListView<User> get getUsers {
    return UnmodifiableListView(_users);
  }

  set setUsers(List<User> usersList) {
    _users = usersList;
    notifyListeners();
  }

  User get getCurrentUser {
    return _currentUser;
  }

  set setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void deleteUser(User user) {
    _users.remove(user);
    notifyListeners();
  }

  void updateUser() {
    notifyListeners();
  }
}
