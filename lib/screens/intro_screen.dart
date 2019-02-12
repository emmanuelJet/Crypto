import 'package:flutter/material.dart';
import 'package:jcrypto/helpers/intro_walkthrough.dart';

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() {
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  int currentPage = 0;
  bool lastPage = false;
  bool firstPage = true;

  static final intro = <Widget> [
    Walkthrough(
      image: 'assets/images/crypto.png',
      title: 'Crypto',
      content: 'Crypto is an app that makes your cryptocurrency world easy and more pleasant',
    ),
    Walkthrough(
      image: 'assets/images/2.png',
      title: 'Real Time',
      content: 'Get real time currency information for over 50 coin in just a click.',
    ),
    Walkthrough(
      image: 'assets/images/coinpot.png',
      title: 'CoinPot & Moon Faucets',
      content: 'Access your seven (7) faucets linked to Coinpot that helps you earn Bitcoin, Bitcoin Cash, Litecoin and 4 other coins.',
    ),
    Walkthrough(
      image: 'assets/images/3.png',
      title: 'Ease To Access',
      content: 'Enjoy converting of currencies using Google currency converter. Easy access to your CoinPot, Moon Faucets and Paxful account',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: DefaultTabController(
        length: intro.length,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 7,
              child: TabBarView(
                children: intro,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: FlatButton(
                  highlightColor: Colors.white,
                  splashColor: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.only(left: 70.0, right: 70.0, top: 15.0, bottom: 15.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(50.0),
                      color: Color(0xFF3d4750)
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0
                      )
                    ),
                  ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TabPageSelector(),
            )
          ],
        ),
      ),
    );
  }
}
