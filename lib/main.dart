import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import './detail.dart';
import './adddata.dart';

void main() {
  runApp(new MaterialApp(
    title: "Data Siswa",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2/my_store/get.php"));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Data Siswa", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) => new AddData(),
          ),
        ),
      ),
      body: new FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(list: snapshot.data!)
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({required this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(5.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new Detail(
                        list: list,
                        index: i,
                      )),
            ),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['Nama'],
                  style: TextStyle(fontSize: 25.0),
                ),
                leading: new Icon(Icons.person),
                subtitle: new Text(
                  "NIS : ${list[i]['NIS']}",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
