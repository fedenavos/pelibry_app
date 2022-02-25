import 'package:flutter/material.dart';
import 'package:watchyapp/api/movies_api.dart';
import 'package:watchyapp/widgets/review_widget.dart';
import 'package:watchyapp/models/movies_data.dart';
import 'package:provider/provider.dart';
import 'package:watchyapp/models/movie.dart';

class MyReviewsTab extends StatelessWidget {
  MyReviewsTab({this.isYours});
  final bool isYours;

  List<Widget> getReviews(MoviesData moviesData) {
    List<ReviewWidget> reviews = [];
    for (Movie movie in moviesData.getMovies) {
      if (movie.reviewText.isNotEmpty || movie.reviewTitle.isNotEmpty) {
        reviews.add(
          ReviewWidget(
            reviewText: movie.reviewText,
            reviewTitle: movie.reviewTitle,
            movieTitle: movie.getNombre,
            deleteFunction: isYours
                ? (String movieName) {
                    reviews.removeWhere(
                        (element) => element.movieTitle == movieName);
                    Movie toRemoveReviewMovie = (moviesData.getMovies
                        .where((element) => element.getNombre == movieName)
                        .first);
                    toRemoveReviewMovie.deleteMovieReview();
                    uploadMovie(toRemoveReviewMovie, true);
                    moviesData.updateMovie();
                  }
                : null,
          ),
        );
      }
    }
    if (reviews.length <= 0) {
      return [
        ReviewWidget(
          reviewTitle: "Todavía no realizó ninguna review",
          movieTitle: "¿Cómo se hace?",
          reviewText: """Agregue una película.
Abrila en la lista para ver los detalles. 
Presiona en 'Escribir reseña'.
Para eliminarla, lo único que tenes que hacer es mantener presionado el cuadro de tu review.""",
          deleteFunction: () {},
        ),
      ];
    }
    return reviews;
  }

  @override
  Widget build(BuildContext context) {
    MoviesData moviesData = Provider.of<MoviesData>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<MoviesData>(
        builder: (context, movieData, child) {
          return GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: getReviews(moviesData),
          );
        },
      ),
    );
  }
}
