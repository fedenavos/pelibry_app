import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watchyapp/models/movie.dart';
import 'package:watchyapp/models/movies_data.dart';

getMovies(
    MoviesData movieData, String email, Function changeShowLoading) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection("movies")
      .orderBy("date")
      .getDocuments();
  List<Movie> _moviesList = [];
  snapshot.documents.forEach((document) {
    Movie movie = Movie.fromMap(document.data);
    if (movie.getOwnerEmail == email) {
      _moviesList.add(movie);
    }
  });
  movieData.setMovies = _moviesList;
  changeShowLoading();
}

deleteMovie(Movie movie) async {
  CollectionReference moviesRef = Firestore.instance.collection("movies");
  await moviesRef.document(movie.getId).delete().catchError((e) {
    print(e);
  });
}

uploadMovie(Movie movie, bool isEditing) async {
  CollectionReference moviesRef = Firestore.instance.collection("movies");

  if (isEditing) {
    await moviesRef
        .document(movie.getId)
        .updateData(movie.toMap())
        .catchError((e) {
      print(e);
    });
    print("updated movie with ID: ${movie.getId}, ${movie.getNombre}");
  } else {
    DocumentReference documentReference = await moviesRef.add(movie.toMap());
    movie.setId = documentReference.documentID;
    documentReference.updateData(movie.toMap());

    await documentReference.setData(movie.toMap(), merge: true);
  }
}
