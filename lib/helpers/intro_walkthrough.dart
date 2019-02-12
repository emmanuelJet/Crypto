import 'package:flutter/material.dart';

class Walkthrough extends StatefulWidget {
  final title;
  final content;
  final image;

  Walkthrough(
    {
      this.title,
      this.content,
      this.image,
    }
  );

  @override
  WalkthroughState createState() {
    return WalkthroughState();
  }
}

class WalkthroughState extends State<Walkthrough> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animation = Tween(
      begin: -250.0, 
      end: 0.0
    ).animate(
      CurvedAnimation(
        parent: animationController, 
        curve: Curves.easeOut
      )
    );
    animation.addListener(() => setState(() {}));
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(20.0),
      child: Material(
        color: Colors.white,
        animationDuration: Duration(milliseconds: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Image.asset(
              widget.image
            ),
            new Text(
              widget.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            new Text(
              widget.content,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15.0,
                color: Colors.black
              )
            ),
          ],
        ),
      ),
    );
  }
}
