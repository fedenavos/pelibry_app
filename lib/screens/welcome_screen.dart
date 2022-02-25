import "package:flutter/material.dart";
import 'package:watchyapp/constants.dart';
import 'package:watchyapp/widgets/reusable_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:watchyapp/screens/registration_screen.dart';
import 'package:watchyapp/screens/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "welcome";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset(
                      "images/Pelibry.png",
                    ),
                    height: 90,
                  ),
                ),
                SizedBox(width: 20),
                TyperAnimatedTextKit(
                  text: ['Pelibry'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                  speed: Duration(milliseconds: 110),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            ReusableButton(
              color: primaryColor,
              ontap: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              text: 'Ingresar',
            ),
            ReusableButton(
              color: thirdColor,
              ontap: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              text: 'Registrarse',
            )
          ],
        ),
      ),
    );
  }
}
