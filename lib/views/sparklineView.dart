import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class SparkLineView extends StatelessWidget {
  // DashTestView({Key key, @required this.accountsDTO}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

    //return new MaterialApp();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sparkline"),
      ),
      body: new Center(
        child: new Container(
          width: 300.0,
          height: 100.0,
          child: new Sparkline(
            data: data,
            pointsMode: PointsMode.all,
            pointSize: 8.0,
            pointColor: Colors.amber,
          ),
        ),
      ),
    );
  }
}
