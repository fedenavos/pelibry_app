import 'package:flutter/material.dart';
import 'package:watchyapp/widgets/list_films.dart';

class MyMoviesTab extends StatelessWidget {
  MyMoviesTab({@required this.loggedEmail, @required this.isYours});

  final String loggedEmail;
  final bool isYours;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MoviesList(
        loggedEmail: loggedEmail,
        isYours: isYours,
      ),
    );
  }
}
