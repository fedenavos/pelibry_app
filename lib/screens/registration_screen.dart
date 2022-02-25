import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:watchyapp/api/users_api.dart';
import 'package:watchyapp/constants.dart';
import 'package:watchyapp/models/user.dart';
import 'package:watchyapp/screens/profile_screen.dart';
import 'package:watchyapp/widgets/alert_dialog_widget.dart';
import 'package:watchyapp/widgets/reusable_button.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showLoading = false;
  String password;
  String email;
  String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showLoading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 180.0,
                    child: Image.asset("images/Pelibry.png"),
                  ),
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  username = value;
                },
                decoration: textInputDecoration2.copyWith(
                    hintText: 'Ingrese su nombre de usuario'),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    textInputDecoration2.copyWith(hintText: 'Ingrese su email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: textInputDecoration2.copyWith(
                    hintText: 'Ingrese una contraseña'),
              ),
              SizedBox(
                height: 24.0,
              ),
              ReusableButton(
                color: thirdColor,
                ontap: () async {
                  setState(() {
                    showLoading = true;
                  });
                  try {
                    var newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, ProfileScreen.id);
                      var user = User(username, email);
                      uploadUser(user, false);
//                      UserData().setCurrentUser = user;
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialogWidget(
                            title: "Registro exitoso",
                            subTitle:
                                "Usuario creado correctamente, ya puede añadir sus películas a la lista!",
                            onTapText: "OK",
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ));
                    }
                    setState(() {
                      showLoading = false;
                    });
                  } catch (e) {
                    print(e);
                    /*return AlertDialogWidget(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      onTapText: "Intentar de nuevo",
                      title: "Error de registro",
                      subTitle: "Ha ocurrido un error al intentar registrarse.",
                    );*/
                  }
                  setState(() {
                    showLoading = false;
                  });
                },
                text: 'Registrarme',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
