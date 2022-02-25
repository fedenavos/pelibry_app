import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watchyapp/models/user.dart';
import 'package:watchyapp/models/users_data.dart';

getUsers(UserData userData) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection("users").getDocuments();
  List<User> _usersList = [];
  snapshot.documents.forEach((document) {
    User user = User.fromMap(document.data);
    _usersList.add(user);
  });
  userData.setUsers = _usersList;
}

deleteUser(User user) async {
  CollectionReference usersRef = Firestore.instance.collection("users");
  await usersRef.document(user.id).delete().catchError((e) {
    print(e);
  });
}

uploadUser(User user, bool isEditing) async {
  CollectionReference usersRef = Firestore.instance.collection("users");

  if (isEditing) {
    await usersRef.document(user.id).updateData(user.toMap()).catchError((e) {
      print(e);
    });
    print("updated user with ID: ${user.id}, ${user.username}");
  } else {
    DocumentReference documentReference = await usersRef.add(user.toMap());
    user.id = documentReference.documentID;
    documentReference.updateData(user.toMap());

    await documentReference.setData(user.toMap(), merge: true);
  }
}

getUserByUsername(String usernameSearched, UserData userData) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection("users").getDocuments();
  User userSearched;
  snapshot.documents.forEach((document) {
    User u = User.fromMap(document.data);
    if (u.username == usernameSearched) {
      userSearched = u;
    }
  });
  userData.setCurrentUser = userSearched;
}
