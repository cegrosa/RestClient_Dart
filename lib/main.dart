import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:resttest/clientrest.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new MaterialApp(
        title: 'Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MyHomePage('Demo Home Page'),
      );
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.title);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var text = new Text("HOLA");

  RestClient client = new RestClient();
  final Uri url = new Uri.http("10.0.2.2:3000", "movie/2");
  final Uri url2 = new Uri.http("10.0.2.2:3000", "movie/");
  Map<String, Object> data;
  List<Map> qwe;

  q() async {
//    qwe = await client.getList(url);
//
//    print("BBB: " + qwe.toString());

    data = await client.getObject(url);

    setState(() {
      text = new Text(data.toString());
    });

    print("BBB: " + data.toString());

    client.post(url2, data);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Result: ',
            ),
            text,
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          q();
        },
        tooltip: 'GET',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
