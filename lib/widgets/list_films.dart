import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:watchyapp/api/movies_api.dart';
import 'package:watchyapp/models/movies_data.dart';
import 'package:provider/provider.dart';
import 'package:watchyapp/screens/detail_screen.dart';
import 'package:watchyapp/constants.dart';

class MoviesList extends StatefulWidget {
  MoviesList({this.loggedEmail, this.isYours});

  final String loggedEmail;
  final bool isYours;

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  bool showLoading = true;

  @override
  void initState() {
    super.initState();
    MoviesData moviesData = Provider.of<MoviesData>(context, listen: false);
    getMovies(moviesData, widget.loggedEmail, () {
      setState(() {
        showLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showLoading,
      child: Consumer<MoviesData>(
        builder: (context, movieData, child) {
          if (movieData.movieCount <= 0) {
            return Center(child: Text("No hay peliculas"));
          }
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return MovieTile(
                    index: index,
                    movieData: movieData,
                    isYours: widget.isYours,
                  );
                },
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black54,
                    ),
                itemCount: movieData.movieCount),
          );
        },
      ),
    );
  }
}

class MovieTile extends StatelessWidget {
  MovieTile({this.index, this.movieData, this.isYours});
  final int index;
  final MoviesData movieData;
  final bool isYours;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        "   ${index + 1}",
        style: TextStyle(
          fontSize: 18,
          color: Colors.black54,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              movieData.getMovies[index].getNombre,
              style: normalTextStyle,
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              movieData.getMovies[index].getValoracionStars(),
              style: pointsTextStyle,
            ),
          ],
        ),
      ),
      trailing: isYours
          ? Icon(
              Icons.chevron_right,
              color: Colors.grey,
            )
          : null,
      onTap: isYours
          ? () {
              movieData.setCurrentMovie = movieData.getMovies[index];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MovieDetail(),
                ),
              );
            }
          : null,
    );
  }
}
