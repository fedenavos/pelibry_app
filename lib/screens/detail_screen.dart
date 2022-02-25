import 'package:flutter/material.dart';
import 'package:watchyapp/models/movies_data.dart';
import 'package:provider/provider.dart';
import 'package:watchyapp/constants.dart';
import 'package:watchyapp/screens/write_review_screen.dart';
import 'package:watchyapp/widgets/reusable_button.dart';
import 'addfilm_screen.dart';
import 'package:watchyapp/models/movie.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MoviesData movieData = Provider.of<MoviesData>(context, listen: false);
    Movie currentMovie = movieData.getCurrentMovie;
    return Scaffold(
      appBar: AppBar(
        title: Text("${currentMovie.getNombre}"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.edit,
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
                child: AddFilmScreen(isEditing: true),
              ),
            ),
          );
        },
      ),
      body: Consumer<MoviesData>(
        builder: (context, moviesData, child) {
          return Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Detalles de la película",
                      style: superTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FilmDetailText(
                    textDescription: "Nombre",
                    textContent: currentMovie.getNombre,
                  ),
                  FilmDetailText(
                    textDescription: "Día que viste la peli",
                    textContent: showDateTime(currentMovie.getDate),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  FilmDetailText(
                    textDescription: "Tu valoración",
                    textContent: "",
                  ),
                  Text(
                    currentMovie.getValoracionStars(),
                    style: TextStyle(fontSize: 25),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 38),
                      child: ReusableButton(
                        ontap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => WriteReview(),
                            ),
                          );
                        },
                        text: "Escribir reseña",
                        color: primaryColor,
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FilmDetailText extends StatelessWidget {
  FilmDetailText({this.textContent, this.textDescription});

  final String textDescription;
  final String textContent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black87,
            fontFamily: fontFamilyUsed,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '$textDescription: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: fontFamilyUsed,
              ),
            ),
            TextSpan(
              text: textContent,
            ),
          ],
        ),
      ),
    );
  }
}
