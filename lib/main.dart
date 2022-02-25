import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchyapp/constants.dart';
import 'package:watchyapp/models/movies_data.dart';
import 'package:watchyapp/screens/login_screen.dart';
import 'package:watchyapp/screens/profile_screen.dart';
import 'package:watchyapp/screens/registration_screen.dart';
import 'package:watchyapp/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseUser loggedInUser;

void getUser() async {
  try {
    await _auth.currentUser().then((value) => loggedInUser = value);
  } catch (e) {
    print(e);
  }
}

/*void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MoviesData(),
        ),
      ],
      child: Pelibry(),
    ),
  );
}

class Pelibry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getUser();
    return MaterialApp(
      title: 'Pelibry',
      theme: ThemeData(
        primaryColor: primaryColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: secondaryColor,
        ),
        fontFamily: fontFamilyUsed,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: loggedInUser == null ? WelcomeScreen.id : ProfileScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
      },
    );
  }
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MoviesData(),
        ),
      ],
      child: Pelibry(email == null ? WelcomeScreen.id : ProfileScreen.id),
    ),
  );
}

class Pelibry extends StatelessWidget {
  Pelibry(this.homePageId);

  final String homePageId;

  @override
  Widget build(BuildContext context) {
    getUser();
    return MaterialApp(
      title: 'Pelibry',
      theme: ThemeData(
        primaryColor: primaryColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: secondaryColor,
        ),
        fontFamily: fontFamilyUsed,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: homePageId,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
      },
    );
  }
}
