import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewScreen extends StatefulWidget {

  final String name;
  final String url;

  WebViewScreen(
    this.name,
    this.url
  );

  _WebViewScreenState createState() => _WebViewScreenState(name, url);
}

class _WebViewScreenState extends State<WebViewScreen> {

  final String name;
  final String url;

  _WebViewScreenState(
    this.name,
    this.url
  );

  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  launchUrl() {
    setState(() {
      flutterWebviewPlugin.reloadUrl(url);
    });
  }

  @override
  void initState() {
    super.initState();
    
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
      print(wvs.type);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: url,
      appCacheEnabled: true,
      withZoom: false,
      withJavascript: true,
      allowFileURLs: true,
      appBar: AppBar(
        title: Text("$name"),
      ),
      initialChild: new Container(
        child: Center(
          child: CircularProgressIndicator(),
        )
      ),
      bottomNavigationBar: BottomAppBar (
        elevation: 2.0,
        color: Color(0xFF3d4750),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  if(flutterWebviewPlugin != null) {
                    flutterWebviewPlugin.goBack();
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.cached,
                  color: Colors.white,
                ),
                onPressed: () {
                  if(flutterWebviewPlugin != null) {
                    flutterWebviewPlugin.reload();
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onPressed: () {
                  if(flutterWebviewPlugin != null) {
                    flutterWebviewPlugin.goForward();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ); 
  }
}