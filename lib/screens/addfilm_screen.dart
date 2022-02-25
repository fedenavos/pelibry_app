import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:watchyapp/api/movies_api.dart';
import 'package:watchyapp/models/movies_data.dart';
import 'package:provider/provider.dart';
import 'package:watchyapp/models/movie.dart';
import 'package:watchyapp/constants.dart';

class AddFilmScreen extends StatefulWidget {
  AddFilmScreen({@required this.isEditing, this.loggedEmail});

  final bool isEditing;
  final String loggedEmail;

  @override
  _AddFilmScreenState createState() => _AddFilmScreenState();
}

class _AddFilmScreenState extends State<AddFilmScreen> {
  int rating = 0;
  String filmText = "";
  DateTime dateTime;
  Movie currentMovie;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      MoviesData moviesData = Provider.of<MoviesData>(context, listen: false);
      currentMovie = moviesData.getCurrentMovie;
      filmText = currentMovie.getNombre;
      rating = currentMovie.getValoracion;
      dateTime = currentMovie.getDate;
    } else {
      currentMovie = Movie.alone();
    }
  }

  @override
  Widget build(BuildContext context) {
    MoviesData moviesData = Provider.of<MoviesData>(context);
    bool isEditing = widget.isEditing;
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              isEditing ? currentMovie.getNombre : 'Añadir película',
              textAlign: TextAlign.center,
              style: superTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextField(
                onChanged: (newText) {
                  currentMovie.setNombre = newText;
                },
                controller: TextEditingController(
                  text: currentMovie.getNombre,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Ingrese el nombre de la película",
                  focusColor: Colors.lightBlueAccent,
                  fillColor: Colors.lightBlueAccent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: SmoothStarRating(
                  rating: rating.toDouble(),
                  isReadOnly: false,
                  size: 35,
                  allowHalfRating: false,
                  filledIconData: Icons.star,
                  defaultIconData: Icons.star_border,
                  starCount: 10,
                  onRated: (value) {
                    currentMovie.setValoracion = value.toInt();
                  },
                ),
              ),
            ),
            ElevatedButton(
              child: Text(
                dateTime == null ? "Ingrese la fecha" : showDateTime(dateTime),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(primaryColor)
              ),
              onPressed: () {
                showDatePicker(
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2100),
                  context: context,
                  initialDate: DateTime.now(),
                ).then((date) {
                  setState(() {
                    currentMovie.setDate = date;
                    dateTime = date;
                  });
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: TextButton(
                onPressed: () {
                  if (currentMovie.validar()) {
                    if (!isEditing) {
                      currentMovie.setOwnerEmail = widget.loggedEmail;
                      moviesData.addFilm(currentMovie);
                    } else {
                      moviesData.updateMovie();
                    }

                    uploadMovie(currentMovie, isEditing);

                    Navigator.pop(context);
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Faltan datos",
                              style: TextStyle(color: Colors.lightBlue),
                            ),
                            content: Text(
                              "Fijese de completar todos los datos antes de guardar",
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(primaryColor)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    isEditing ? "Guardar cambios" : 'Agregar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            isEditing
                ? ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: primaryColor),
                            ),
                        ),
                    ),
                    onPressed: () {
                      moviesData.deleteMovie(currentMovie);
                      deleteMovie(currentMovie);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )
                : SizedBox(
                    height: 5,
                  ),
          ],
        ),
      ),
    );
  }
}
