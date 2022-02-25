import 'package:flutter/material.dart';
import 'package:watchyapp/api/movies_api.dart';
import 'package:watchyapp/constants.dart';
import 'package:watchyapp/models/movie.dart';
import 'package:watchyapp/models/movies_data.dart';
import 'package:provider/provider.dart';
import 'package:watchyapp/screens/profile_screen.dart';
import 'package:watchyapp/widgets/reusable_button.dart';

class WriteReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MoviesData movieData = Provider.of<MoviesData>(context, listen: false);
    Movie currentMovie = movieData.getCurrentMovie;
    bool isEditing = true;
    if (currentMovie.reviewText == "" || currentMovie.reviewTitle == "") {
      isEditing = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Tu Review"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  currentMovie.getNombre,
                  style: superTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              TextField(
                onChanged: (newReviewTitle) {
                  currentMovie.reviewTitle = newReviewTitle;
                },
                controller: TextEditingController(
                  text: isEditing ? currentMovie.reviewTitle : null,
                ),
                textAlign: TextAlign.center,
                maxLength: 50,
                decoration: InputDecoration(
                  hintText: "Escriba el título de su review",
                  focusColor: Colors.lightBlueAccent,
                  fillColor: Colors.lightBlueAccent,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: TextField(
                  onChanged: (newReviewText) {
                    currentMovie.reviewText = newReviewText;
                  },
                  controller: TextEditingController(
                    text: isEditing ? currentMovie.reviewText : null,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  minLines: 1,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: "¿Qué opina de la película?",
                    focusColor: Colors.lightBlueAccent,
                    fillColor: Colors.lightBlueAccent,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: ReusableButton(
                  color: primaryColor,
                  text: "Guardar reseña",
                  ontap: () {
                    uploadMovie(currentMovie, true);
                    Navigator.pushReplacementNamed(context, ProfileScreen.id);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
