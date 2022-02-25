import "package:flutter/material.dart";
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchyapp/constants.dart';
import 'package:watchyapp/screens/profile_screen.dart';
import 'package:watchyapp/widgets/alert_dialog_widget.dart';
import 'package:watchyapp/widgets/reusable_button.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String password;
  String email;
  bool showLoading = false;

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
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    textInputDecoration.copyWith(hintText: 'Ingrese su email'),
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
                decoration: textInputDecoration.copyWith(
                    hintText: 'Ingrese su contraseña'),
              ),
              SizedBox(
                height: 24.0,
              ),
              ReusableButton(
                color: primaryColor,
                ontap: () async {
                  setState(() {
                    showLoading = true;
                  });
                  try {
                    final loggedUser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (loggedUser != null) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('email', email);
                      Navigator.pushNamed(context, ProfileScreen.id);
                    }
                    setState(() {
                      showLoading = false;
                    });
                  } catch (e) {
                    print(e);
                    setState(() {
                      showLoading = false;
                    });
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialogWidget(
                        title: "Error en el ingreso",
                        subTitle: "Usuario o contraseña incorrectos",
                        onTapText: "Intentar de nuevo",
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    );
                  }
                },
                text: 'Ingresar',
              )
            ],
          ),
        ),
      ),
    );
  }
}
