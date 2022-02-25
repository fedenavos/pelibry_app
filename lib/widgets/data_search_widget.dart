import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchyapp/api/movies_api.dart';
import 'package:watchyapp/api/users_api.dart';
import 'package:watchyapp/models/user.dart';
import 'package:watchyapp/models/users_data.dart';
import 'package:watchyapp/screens/friend_profile_screen.dart';
import 'package:watchyapp/models/movies_data.dart';

class DataSearch extends SearchDelegate<String> {
  DataSearch(this.userData, this.emailOwner);

  final UserData userData;
  final String emailOwner;
  final recentUsers = [User("fedenavos", "fedenavos@gmail.com")];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        MoviesData moviesData = Provider.of<MoviesData>(context, listen: false);
        getMovies(moviesData, emailOwner, () {});
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FriendProfile(user: userData.getCurrentUser);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentUsers
        : userData.getUsers.where((u) => u.username.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () async {
          await getUserByUsername(suggestionList[index].username, userData);
          query = userData.getCurrentUser.username;
          showResults(context);
        },
        leading: Icon(Icons.account_circle),
        title: Text(suggestionList[index].username),
      ),
      itemCount: suggestionList.length,
    );
  }
}
