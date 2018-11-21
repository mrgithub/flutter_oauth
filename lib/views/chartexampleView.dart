import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Multi Page Application Page - 1"),
        ),
        body: new Checkbox(
            value: false,
            onChanged: (bool newValue) {
              Navigator.pop(ctxt); // Pop from stack
            }));
  }
}
