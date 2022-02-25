import 'package:flutter/material.dart';
import 'package:watchyapp/constants.dart';

class ReviewWidget extends StatelessWidget {
  ReviewWidget(
      {this.reviewTitle,
      this.reviewText,
      this.movieTitle,
      this.deleteFunction});

  final String reviewText;
  final String reviewTitle;
  final String movieTitle;
  final Function deleteFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              movieTitle,
              style: headlineTextStyle.copyWith(color: primaryColor),
            ),
            content: SingleChildScrollView(
              child: Text(
                reviewText,
                style: TextStyle(height: 1.5),
              ),
            ),
            scrollable: true,
          ),
        );
      },
      onLongPress: () {
        deleteFunction(movieTitle);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.blue[700],
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ],
            color: Colors.white70,
            /*border: Border.all(
              style: BorderStyle.solid,
              color: Colors.blue[800],
            ),*/
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*Expanded(
                child: Image.network(
                  "https://vignette.wikia.nocookie.net/marvelcinematicuniverse/images/9/9b/Avenger_Endgame_Poster_Oficial.png/revision/latest/scale-to-width-down/337?cb=20190326185910&path-prefix=es",
                  width: 100,
                  height: 200,
                ),
              ),*/
              Text(
                '"$reviewTitle"',
                style: headlineTextStyle.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
