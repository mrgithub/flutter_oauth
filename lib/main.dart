import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

//import 'package:http/browser_client.dart';

void main() => runApp(new MyApp());

Token accessToken;


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Oauth Try',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  var txt = new TextEditingController();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            new RaisedButton(
              onPressed: _processLogin, //_launchURL,
              child: new Text('Show Flutter homepage1'),
            ),
            new TextField(controller: txt),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _processLogin() async {

    accessToken = await getToken();
    txt.text = DateTime.now().second.toString()+": " + accessToken.getAccess;

//    print("step 1 ********************* ");
    const listAccountsUri = "https://api.truelayer.com/data/v1/accounts";

    var x = accessToken.getAccess;

    final response = await http.get(listAccountsUri,
      headers: {
        'authorization' : 'bearer $x',
        'content-type':'application/json'
      },
    );


    var d = jsonDecode(response.body);
    print("step 1b: $d" );
    print("step 2 ********************* " + response.body);

    final responseJson = json.decode(response.body);
    print("listAccounts ********************* " + response.body);

  }




  Future<Token> getToken() async {
    const authenticateUrl =
        "https://auth.truelayer.com/?response_type=code&client_id=testapp-vylt&nonce=2250806897&scope=info%20accounts%20balance%20transactions%20cards%20offline_access&redirect_uri=http://localhost:3000/callback&enable_mock=true&enable_oauth_providers=true&enable_open_banking_providers=false&enable_credentials_sharing_providers=true";

    const clientId = 'testapp-vylt';
    const redirectUrl = 'http://localhost:3000/callback';
    const appSecret = 'legdky8lt3n5r622p4hfbi';
    const tokenUrl = 'https://auth.truelayer.com/connect/token';

    Stream<String> onCode = await _localServer();
    final flutterWebviewPlugin = new FlutterWebviewPlugin();

    // direct user to authentication server and retrieve the authorisation code
    flutterWebviewPlugin.launch(authenticateUrl);
    final String code = await onCode.first;

    // post retrieved authorisation code to the server and exchange for a access token
    final http.Response response = await http.post(tokenUrl, body: {
      'client_id': clientId,
      'redirect_uri': redirectUrl,
      'client_secret': appSecret,
      'code': code,
      'grant_type': 'authorization_code'
    });

    flutterWebviewPlugin.close();

    print("getToken ********************* " + response.body);
    return new Token.fromMap(jsonDecode(response.body));
  }


//  Future<Post> fetchPost() async {
//    final response = await http.get(
//      'https://jsonplaceholder.typicode.com/posts/1',
//      headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
//    );
//    final responseJson = json.decode(response.body);
//
//    return Post.fromJson(responseJson);
//  }




  // server that listens to the postback from the authentication server
  Future<Stream<String>> _localServer() async {
    final StreamController<String> onCode = new StreamController();
    HttpServer server =
        await HttpServer.bind(InternetAddress.loopbackIPv4, 3000);
    server.listen((HttpRequest request) async {
      final String code = request.uri.queryParameters["code"];
      request.response
            ..statusCode = 200
            ..headers.set("Content-Type", ContentType.html.mimeType)
          ..write("<html>window closing</html>")
          ;
      await request.response.close();
      await server.close(force: true);
      onCode.add(code);
      await onCode.close();
    });

    return onCode.stream;
  }
}

// delete this
class Token {
   String _access;
//  String id;
//  String username;
//  String full_name;
//  String profile_picture;

  String get getAccess => _access;

  Token.fromMap(Map json) {
    _access = json['access_token'];
//    id = json['user']['id'];
//    username = json['user']['username'];
//    full_name = json['user']['full_name'];
//    profile_picture = json['user']['profile_picture'];
  }
}

//class AccountNumber {
//  final String iban;	//	ISO 13616-1:2007 international bank number
//  final String number;	//	Bank account number
//  final String sort_code;	//	United Kingdom SORT code
//  final String swift_bic;	//	ISO 9362:2009 Business Identifier Codes
//
//  AccountNumber.fromMap(Map json) {
//    iban = json['access_token'];
//    number = json['user']['id'];
//    sort_code = json['user']['username'];
//    swift_bic = json['user']['full_name'];
//  }
//}
//
//
//class Accounts {
//  final int userId;
//  final int id;
//  final String title;
//  final String body;
//
//
//  final String account_id;	//	Unique identifier of the account
//  final String account_type;	//	Type of the account
//  final AccountNumber account_number;
//  final String currency;	//	ISO 4217 alpha-3 currency code of the account
//
//  final String display_name	//	Human readable name of the account
//   update_timestamp	datetime	Last update time of the account information
//  provider.display_name	string	Display name for the Provider
//  provider.logo_uri	string	Uri for the Provider logo
//  provider.provider_id
//
//
//  Accounts({this.userId, this.id, this.title, this.body});
//
//  factory Accounts.fromJson(Map<String, dynamic> json) {
//    return Accounts(
//      userId: json['userId'],
//      id: json['id'],
//      title: json['title'],
//      body: json['body'],
//    );
//  }
//
