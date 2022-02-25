import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  String _id = "";

  String get getId {
    return _id;
  }

  set setId(String id) {
    _id = id;
  }

  String _nombre;

  String get getNombre {
    return _nombre;
  }

  set setNombre(String nombre) {
    _nombre = nombre;
  }

  int _valoracion;

  int get getValoracion {
    return _valoracion;
  }

  set setValoracion(int valoracion) {
    _valoracion = valoracion;
  }

  Timestamp _dateWatch;

  DateTime get getDate {
    if (_dateWatch == null) {
      return null;
    } else {
      return _dateWatch.toDate();
    }
  }

  set setDate(DateTime date) {
    _dateWatch = Timestamp.fromDate(date);
  }

  String _reviewTitle = "";

  String get reviewTitle => _reviewTitle;

  set reviewTitle(String value) {
    _reviewTitle = value;
  }

  String _reviewText = "";

  String get reviewText => _reviewText;

  set reviewText(String value) {
    _reviewText = value;
  }

  String _ownerEmail;

  String get getOwnerEmail => _ownerEmail;

  set setOwnerEmail(String value) {
    _ownerEmail = value;
  }

  Movie.fromMap(Map<String, dynamic> data) {
    _id = data["id"];
    _nombre = data["nombre"];
    _valoracion = data["valoracion"];
    _dateWatch = data["date"];
    _reviewTitle = data["reviewTitle"];
    _reviewText = data["reviewText"];
    _ownerEmail = data["email"];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'date': _dateWatch,
      'nombre': _nombre,
      'valoracion': _valoracion,
      'reviewTitle': _reviewTitle,
      'reviewText': _reviewText,
      'email': _ownerEmail,
    };
  }

  Movie.alone();

  Movie(
    this._nombre,
    this._valoracion,
    this._dateWatch,
  );

  String getValoracionStars() {
    return ("✪" * _valoracion) + " ($_valoracion)";
  }

  bool validar() {
    if (getNombre == null || getDate == null || getValoracion == null) {
      return false;
    }
    return true;
  }

  void deleteMovieReview() {
    reviewText = "";
    reviewTitle = "";
  }
}
