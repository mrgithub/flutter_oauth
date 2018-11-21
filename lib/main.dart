import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_oauth/views/chartexampleView.dart';
import 'package:http/http.dart' as http;

import 'dtos/accountBalanceDTO.dart';
import 'dtos/accountsDTO.dart';
import 'helpers/credentialsHelper.dart';
import 'views/accountTransactionView.dart';
import 'views/multipleHorizontalButtonsView.dart';
import 'views/sparklineView.dart';

void main() => runApp(new MyApp());

//Token accessToken;
//Credentials credentials = new Credentials();

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
      home: new MyHomePage(title: 'MBank'),
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

////picker stuff??
//  final double listSpec = 8.0;
//  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//  String stateText;

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
              child: new Text('Get Token'),
            ),
            new RaisedButton(
              onPressed: _getOneAccount,
              child: new Text('Get One Account'),
            ),
            new RaisedButton(
              onPressed: _getAccountBalance,
              child: new Text('Get Balance'),
            ),
            new RaisedButton(
              onPressed: _getAccountsList,
              child: new Text('List Accounts'),
            ),
            new RaisedButton(
              onPressed: _horizontalTest,
              child: new Text('Horizontal test'),
            ),
            new RaisedButton(
              onPressed: _sparkTest,
              child: new Text('Spark test'),
            ),
            new RaisedButton(
              onPressed: _dashTest,
              child: new Text('Chart test'),
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

  void _sparkTest() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SparkLineView(),
      ),
    );
  }

  void _dashTest() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondScreen(),
      ),
    );
  }

  void _horizontalTest() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultipleHorizontalButtonsView(),
      ),
    );
  }

  _getOneAccount() async {
    const String oneAccountId = "56c7b029e0f8ec5a2334fb0ffc2fface";

    const oneAccountUri =
        "https://api.truelayer.com/data/v1/accounts/$oneAccountId";

    var x = new Credentials().getToken;

    final response = await http.get(
      oneAccountUri,
      headers: {
        'authorization': 'bearer $x',
        'content-type': 'application/json'
      },
    );

    txt.text = DateTime.now().second.toString() + ": Account: ";

    print("one account ********************* " + response.body);
  }

  _getAccountBalance() async {
    const String oneAccountId = "56c7b029e0f8ec5a2334fb0ffc2fface";

    const accountBalanceUri =
        "https://api.truelayer.com/data/v1/accounts/$oneAccountId/balance";

    var token = new Credentials().getToken;

    final response = await http.get(
      accountBalanceUri,
      headers: {
        'authorization': 'bearer $token',
        'content-type': 'application/json'
      },
    );

    AccountBalanceDTO d =
    new AccountBalanceDTO.fromJson(jsonDecode(response.body));

    print("account balance ********************* " + response.body);
    txt.text = DateTime.now().second.toString() +
        ": Balance: " +
        d.accountBalance.available.toString();
  }

  _getAccountsList() async {
    const accountListUri = "https://api.truelayer.com/data/v1/accounts";

    var token = new Credentials().getToken;

    final response = await http.get(
      accountListUri,
      headers: {
        'authorization': 'bearer $token',
        'content-type': 'application/json'
      },
    );

    print("account list ********************* " + response.body);

    var d = new AccountsDTO.fromJson(jsonDecode(response.body));

    txt.text = DateTime.now().second.toString() +
        ": accounts List: " +
        d.accounts.length.toString() +
        d.accounts.first.accountNumber.sort_code.toString() +
        " ..." +
        d.accounts.first.provider.display_name;

    //showPicker(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountListScreen(accountsDTO: d),
      ),
    );
  }

  _processLogin() async {
    await getCredentials();
    txt.text = DateTime.now().toLocal().toString() +
        ": " +
        new Credentials().getToken; // accessToken._access;
  }
}
