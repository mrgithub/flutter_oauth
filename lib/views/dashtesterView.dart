import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class DashTestView extends StatelessWidget {

  // DashTestView({Key key, @required this.accountsDTO}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

    //return new MaterialApp();

    return new MaterialApp(
      home: new Scaffold(
        body: new Center(
          child: new Container(
            width: 300.0,
            height: 100.0,
            child: new Sparkline(
                data: data
            ),
          ),
        ),
      ),
    );

  }
}

