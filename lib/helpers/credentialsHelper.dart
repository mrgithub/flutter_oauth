import 'dart:io';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Credentials {

  // ** code to make this a singleton by storing internal reference to itself
  static final Credentials _singleton = new Credentials._internal();
  factory Credentials() => _singleton;  // factory constructor, returns static variable
  Credentials._internal();  // private, named constructor
  // **

  // assign token from the json map
  static String _token;
  Credentials.fromMap(Map json) {
    _token = json['access_token'];
  }

  // public getter for the static variable
  String get getToken => _token;
}


Future<Credentials> getCredentials() async {
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

  // print("getToken ********************* " + response.body);
  //return new Token.fromMap(jsonDecode(response.body));
  return new Credentials.fromMap(jsonDecode(response.body));
}

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
          ..write("<html>window closing</html>");
        await request.response.close();
        await server.close(force: true);
        onCode.add(code);
        await onCode.close();
  });

  return onCode.stream;
}
