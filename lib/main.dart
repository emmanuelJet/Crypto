import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jcrypto/screens/home_screen.dart';
import 'package:jcrypto/screens/intro_screen.dart';
import 'package:jcrypto/screens/quit_screen.dart';
import 'package:jcrypto/screens/splash_screen.dart';

void main() async{
  List currencies = await getCurrencies();
  print(currencies);

  runApp(MyApp(currencies));
} 

class MyApp extends StatelessWidget {

  final List _currencies;
  MyApp(this._currencies);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Color(0xFF3d4750),
        accentColor: Color(0xFF323a41),
        fontFamily: 'Avian',
      ),
      title: "Crypto",
      home: SplashScreen(),
      routes: <String, WidgetBuilder> {
        "/quit": (BuildContext context) => QuitScreen(),
        "/intro": (BuildContext context) => IntroScreen(),
        "/home": (BuildContext context) => HomeScreen(_currencies),
      },
    );
  }
}

Future<List> getCurrencies() async {
  print("attempting");
  String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=100";
  http.Response response = await http.get(cryptoUrl);
  return json.decode(response.body); 
}