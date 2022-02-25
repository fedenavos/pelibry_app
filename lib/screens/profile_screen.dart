import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchyapp/api/users_api.dart';
import 'package:watchyapp/models/users_data.dart';
import 'package:watchyapp/screens/addfilm_screen.dart';
import 'package:watchyapp/screens/welcome_screen.dart';
import 'package:watchyapp/tabs/myMovies_tab.dart';
import 'package:watchyapp/tabs/myReviews_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:watchyapp/widgets/data_search_widget.dart';

FirebaseUser loggedInUser;

class ProfileScreen extends StatefulWidget {
  static String id = "profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 30,
          ),
          elevation: 7,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: AddFilmScreen(
                    isEditing: false,
                    loggedEmail: loggedInUser.email,
                  ),
                ),
              ),
            );
          },
        ),
        appBar: AppBar(
          title: Text("Mi Perfil 2020"),
          automaticallyImplyLeading: false,
          leading: null,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                UserData userData = UserData();
                getUsers(userData);
                showSearch(
                    context: context,
                    delegate: DataSearch(userData, loggedInUser.email));
              },
            ),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  _auth.signOut();
                  loggedInUser = null;
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('email', null);
                  Navigator.pushReplacementNamed(context, WelcomeScreen.id);
                }),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.list)),
              Tab(icon: Icon(Icons.local_movies)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            loggedInUser != null
                ? MyMoviesTab(loggedEmail: loggedInUser.email, isYours: true)
                : SizedBox(),
            MyReviewsTab(isYours: true),
          ],
        ),
        drawer: Drawer(),
      ),
    );
  }
}
