import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class QuitScreen extends StatefulWidget {

  @override
  QuitScreenState createState() {
    return new QuitScreenState();
  }
}

class QuitScreenState extends State<QuitScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => exit(0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color(0xFF3d4750),),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Center(
                    child: Text(
                      'Crypto',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0
                      ),
                    ),
                  )
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}