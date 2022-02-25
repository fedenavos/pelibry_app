import 'package:flutter/material.dart';
import 'package:watchyapp/models/user.dart';
import 'package:watchyapp/tabs/myMovies_tab.dart';
import 'package:watchyapp/tabs/myReviews_tab.dart';

class FriendProfile extends StatelessWidget {
  FriendProfile({this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(user.username),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.list)),
              Tab(icon: Icon(Icons.local_movies)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            user != null
                ? MyMoviesTab(loggedEmail: user.email, isYours: false)
                : SizedBox(),
            MyReviewsTab(isYours: false),
          ],
        ),
        drawer: Drawer(),
      ),
    );
  }
}
