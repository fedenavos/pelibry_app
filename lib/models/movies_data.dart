import "dart:collection";
import 'package:flutter/foundation.dart';
import 'package:watchyapp/models/movie.dart';

class MoviesData extends ChangeNotifier {
  List<Movie> _movies = [];
  Movie _currentMovie;

  int get movieCount {
    return _movies.length;
  }

  void addFilm(Movie newMovie) {
    _movies.add(newMovie);
    _movies.sort((a, b) {
      if (a.getDate.isAfter(b.getDate)) {
        return 1;
      } else {
        return 0;
      }
    });
    notifyListeners();
  }

  UnmodifiableListView<Movie> get getMovies {
    return UnmodifiableListView(_movies);
  }

  set setMovies(List<Movie> moviesList) {
    _movies = moviesList;
    notifyListeners();
  }

  Movie get getCurrentMovie {
    return _currentMovie;
  }

  set setCurrentMovie(Movie movie) {
    _currentMovie = movie;
    notifyListeners();
  }

  void deleteMovie(Movie movie) {
    _movies.remove(movie);
    notifyListeners();
  }

  void updateMovie() {
    notifyListeners();
    print("si");
  }
}
