import 'package:flutter/material.dart';

class MultipleHorizontalButtonsView extends StatelessWidget {

  // DashTestView({Key key, @required this.accountsDTO}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new ButtonOptions());
  }
}


class ButtonOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ButtonOptionsState();
  }
}

class ButtonOptionsState extends State<ButtonOptions> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('First Screen'),
        ),
        body: new Container(
            height: 100.0,
            child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: 7,
                // itemExtent: 10.0,
                // reverse: true, //makes the list appear in descending order
                itemBuilder: (BuildContext context, int index) {
                  return _buildItems(index);
                })));
  }
}

Widget _buildItems(int index) {
  return new Container(
    // color: Colors.blue,
  //var txt = new TextEditingController();

    padding: const EdgeInsets.all(10.0),
    child: new Row(
      children: [
        new Row(children: [
          new RaisedButton(
            child: new Text("HiB" + index.toString()),
            onPressed: () { },
          ),
        ])
      ],
    ),
  );
}