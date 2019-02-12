import 'package:flutter/material.dart';

class JNavigator {

  static void goToQuit(BuildContext context, bool) {
    Navigator.pushNamed(context, "/quit");
  }

  static void goToIntro(BuildContext context) {
    Navigator.pushNamed(context, "/intro");
  }

  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

}
