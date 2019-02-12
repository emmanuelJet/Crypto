import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jcrypto/helpers/navigator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jcrypto/screens/webview_screen.dart';
import 'package:connectivity/connectivity.dart';

class HomeScreen extends StatefulWidget {

  final List currencies;
  HomeScreen(this.currencies);
  
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  var dateFormat = new DateFormat('dd.MM.yyyy');

  var _isLoading = false; 

  List currencies;
  final List<MaterialColor> _colors = [
    Colors.red,
    Colors.blue,
    Colors.indigo,
    Colors.teal,
  ];

  String _connectionStatus;
  final Connectivity _connectivity = new Connectivity();

  StreamSubscription<ConnectivityResult> _connectionSubscription;

  @override
  void initState() {
    super.initState();
    _connectionSubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result.toString();
      });
    });
    print("Initstate : $_connectionStatus");
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }

  initConnectivity() async {
    String connectionStatus;

    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } catch (e) {
      print(e.toString());
      connectionStatus = "Internet connectivity failed";
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _connectionStatus = connectionStatus;
    });
    print("InitConnectivity : $_connectionStatus");
    if(_connectionStatus == "ConnectivityResult.mobile" || _connectionStatus == "ConnectivityResult.wifi") {
      fecthCoin();
    } else {
      showDialog (
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Crypto"),
          content: Text("Kindly Connect To The Internet And Try Again"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        )
      );
    }
  }

  fecthCoin() async {
    print("attempting");
    final url = "https://api.coinmarketcap.com/v1/ticker/?limit=100";
    http.Response response = await http.get(url);
  
    print(response);
    setState(() {
      _isLoading = false;
    });

    return json.decode(response.body); 
  }

  Future<bool> _onBackPressed() {
    return showDialog (
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Crypto"),
        content: Text("Do you really want to close the app?"),
        actions: <Widget>[
          FlatButton(
            child: Text("No"),
            onPressed: () => Navigator.pop(context,false),
          ),
          FlatButton(
            child: Text("Yes"),
            onPressed: () => JNavigator.goToQuit(context, true),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF3d4750),
          centerTitle: true,
          title: Text("Crypto"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                initConnectivity();
              }
            )
          ],
        ),
        drawer: Drawer(
          child: Container(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF28363d), Color(0xFF323a41)],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    tileMode: TileMode.clamp
                  )
                ),
                child: Center(
                  child: Text('Cypto',
                      softWrap: true,
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: Colors.white, fontSize: 25.0)),
                ),
              ),
              ListTileTheme( 
                child: new ListTile(
                  title: Text('Converter',
                      overflow: TextOverflow.clip,
                      style: TextStyle(fontSize: 18.0)),
                  leading: new Icon(Icons.cached),
                  onTap: () {
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new WebViewScreen('Crypto Converter', 'https://google.com/search?q=1+btc+to+usd&amp;rlz=1C1CHBD_enNG820NG820&amp')
                      )
                    );
                  },
                ),
                iconColor: Color(0xFF3d4750),
              ),
              Divider(),
              ExpansionTile(
                leading: Icon(Icons.monetization_on),
                title: Text(
                  'Moon Faucets',
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 18.0)
                ),
                children: <Widget>[
                  ListTileTheme(
                    child: ListTile(
                      title: Text('Moon BitCash',
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 15.0)
                      ),
                      leading: new Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new WebViewScreen('Moon Bitcash', 'http://moonbitcoin.cash/?ref=82CA6C59F0CB')
                          )
                        );
                      },
                    ),
                    iconColor: Color(0xFF3d4750),
                  ),
                  ListTileTheme(
                    child: ListTile(
                      title: Text('Moon BitCoin',
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 15.0)
                      ),
                      leading: new Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new WebViewScreen('Moon Bitcoin', 'http://moonbit.co.in/?ref=13a316dc2305')
                          )
                        );
                      },
                    ),
                    iconColor: Color(0xFF3d4750),
                  ),
                  ListTileTheme(
                    child: ListTile(
                      title: Text('Bit Fun',
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 15.0)
                      ),
                      leading: new Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new WebViewScreen('Bit Fun', 'http://bitfun.co/?ref=41190671BCAB')
                          )
                        );
                      },
                    ),
                    iconColor: Color(0xFF3d4750),
                  ),
                  ListTileTheme(
                    child: ListTile(
                      title: Text('Bonus Bitcoin',
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 15.0)
                      ),
                      leading: new Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new WebViewScreen('Bonus Bitcoin', 'http://bonusbitcoin.co/?ref=8DE50EB31972')
                          )
                        );
                      },
                    ),
                    iconColor: Color(0xFF3d4750),
                  ),
                  ListTileTheme(
                    child: ListTile(
                      title: Text('Moon Litecoin',
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 15.0)
                      ),
                      leading: new Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new WebViewScreen('Moon Litecoin', 'http://moonliteco.in/?ref=1af57a32fb3d')
                          )
                        );
                      },
                    ),
                    iconColor: Color(0xFF3d4750),
                  ),
                  ListTileTheme(
                    child: ListTile(
                      title: Text('Moon DogeCoin',
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 15.0)
                      ),
                      leading: new Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new WebViewScreen('Moon Dogecoin', 'http://moondoge.co.in/?ref=6db0fb06f349')
                          )
                        );
                      },
                    ),
                    iconColor: Color(0xFF3d4750),
                  ),
                  ListTileTheme(
                    child: ListTile(
                      title: Text('Moon Dashcoin',
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 15.0)
                      ),
                      leading: new Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new WebViewScreen('Moon DashCoin', 'http://moondash.co.in/?ref=B7B5023283BA')
                          )
                        );
                      },
                    ),
                    iconColor: Color(0xFF3d4750),
                  ),
                ]
              ),
              ListTileTheme( 
                child: new ListTile(
                  title: Text('CoinPot',
                    overflow: TextOverflow.clip,
                    style: TextStyle(fontSize: 18.0)
                  ),
                  leading: new Icon(Icons.attach_money),
                  onTap: () {
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new WebViewScreen('Crypto CoinPot', 'https://coinpot.co')
                      )
                    );
                  },
                ),
                iconColor: Color(0xFF3d4750),
              ),
              Divider(),
              ExpansionTile(
                leading: Icon(Icons.monetization_on),
                title: Text(
                  'Other Faucets',
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 18.0)
                ),
                children: <Widget>[
                  ListTileTheme( 
                    child: new ListTile(
                      title: Text('Crypto BTCClicks',
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 18.0)
                      ),
                      leading: new Icon(Icons.attach_money),
                      onTap: () {
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new WebViewScreen('Crypto BTCClicks', 'https://btcclicks.com/?r=873cf237')
                          )
                        );
                      },
                    ),
                    iconColor: Color(0xFF3d4750),
                  ),
                ]
              ),
              Divider(),
              ListTileTheme( 
                child: new ListTile(
                  title: Text('PaxFul',
                    overflow: TextOverflow.clip,
                    style: TextStyle(fontSize: 18.0)
                  ),
                  leading: new Icon(Icons.payment),
                  onTap: () {
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new WebViewScreen('Crypto PaxFul', 'https://paxful.com')
                      )
                    );
                  },
                ),
                iconColor: Color(0xFF3d4750),
              ),
            ]),
          ),
        ),
        body: Center(
          child: _isLoading
                ? CircularProgressIndicator()
                : _cryptoWidget(),
        ),
      ),
    );
  }

  Widget  _cryptoWidget() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemCount: widget.currencies.length,
              itemBuilder: (BuildContext context, int index) {
                final Map currency = widget.currencies[index];
                final MaterialColor color = _colors[index % _colors.length];

                return _getListItemUi(currency,color);
              },
            ),
          ),
        ],
      )
    );
  }

  Card _getListItemUi(Map currency, MaterialColor color) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(7.0),
        child: new ListTile(
          title: new Text(
            currency['name'],
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),
          ),
          subtitle: _getSubtitleText(
            currency['price_usd'],
            currency['price_btc'],
            currency['percent_change_1h'],
            currency['percent_change_7d'],
            currency['rank'],
            currency['symbol'],
            currency['last_updated'],
          ),
          trailing: new CircleAvatar(
            backgroundColor: color,
            child: new Text(
              currency['symbol'],
              style: TextStyle(
                fontFamily: 'Avian'
              ),
            ),
          ),
          isThreeLine: true,
        ),
      ),
    );
  }

  Widget _getSubtitleText(String priceUSD, String priceBTC, String perChangePerHour, String perChangePer7D, String rank, String logo, String lastUpdated) {

    TextSpan rankTextWidget = new TextSpan(
      text: "$rank position\n",
      style: new TextStyle(
        color: Colors.black,
        fontFamily: 'Avian',
      )
    );

    TextSpan priceUSDTextWidget = new TextSpan(
      text: "Value: \$$priceUSD\n",
      style: new TextStyle(
        color: Colors.black,
        fontFamily: 'Avian',
      )
    );

    TextSpan priceBTCTextWidget = new TextSpan(
      text: "Rate: $priceBTC $logo\nLast Updated: ",
      style: new TextStyle(
        color: Colors.black,
        fontFamily: 'Avian',
      )
    );

    String perChangePerHourText = "\n1 hour: $perChangePerHour%\n";
    TextSpan perChangePerHourTextWidget;
    if(double.parse(perChangePerHour) > 0) {
      perChangePerHourTextWidget = new TextSpan(
        text: perChangePerHourText,
        style: new TextStyle(
          color: Colors.green,
          fontFamily: 'Avian',
        )
      );
    } else {
      perChangePerHourTextWidget = new TextSpan(
        text: perChangePerHourText,
        style: new TextStyle(
          color: Colors.red,
          fontFamily: 'Avian'
        )
      );
    }

    String perChangePer7DText = "7 days: $perChangePer7D%";
    TextSpan perChangePer7DTextWidget;
    if(double.parse(perChangePer7D) > 0) {
      perChangePer7DTextWidget = new TextSpan(
        text: perChangePer7DText,
        style: new TextStyle(
          color: Colors.green,
          fontFamily: 'Avian',
        )
      );
    } else {
      perChangePer7DTextWidget = new TextSpan(
        text: perChangePer7DText,
        style: new TextStyle(
          color: Colors.red,
          fontFamily: 'Avian' 
        )
      );
    }

    String lastUpdatedText = "$lastUpdated";
    TextSpan lastUpdatedTextWidget = new TextSpan(
      text: dateFormat
              .format(DateTime.fromMillisecondsSinceEpoch(
                int.parse(lastUpdatedText) * 1000,
              ))
              .toString(),
      style: new TextStyle(
        color: Colors.black,
        fontFamily: 'Avian',
      )
    );


    return new RichText(
      text: new TextSpan(
        children: [
          rankTextWidget, 
          priceUSDTextWidget, 
          priceBTCTextWidget, 
          lastUpdatedTextWidget,
          perChangePerHourTextWidget,
          perChangePer7DTextWidget,
        ]
      ),
    );
  }
}