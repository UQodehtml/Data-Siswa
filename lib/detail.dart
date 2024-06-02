import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import './editdata.dart';
import './main.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({required this.index, required this.list});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData() {
    var url = Uri.parse("http://10.0.2.2/my_store/deletedata.php");

    http.post(url, body: {"ID": widget.list[widget.index]['ID']});
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
        "Apakah Anda Yakin Ingin Menghapus Data ${widget.list[widget.index]['Nama']}?",
        style: TextStyle(fontSize: 25.0),
      ),
      actions: <Widget>[
        new ElevatedButton(
          child: new Text("Ya", style: new TextStyle(color: Colors.white, fontSize: 20.0)),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            deleteData();
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new Home()),
            );
          },
        ),
        new ElevatedButton(
          child: new Text("Batal", style: new TextStyle(color: Colors.white, fontSize: 20.0)),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:
          new AppBar(
            title: new Text("Data ${widget.list[widget.index]['Nama']}", 
            style: TextStyle(fontSize: 25.0, 
            fontWeight: FontWeight.bold),
          ),backgroundColor: Colors.blue,),
      body: new Container(
        height: 320.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(top: 30.0)),
                new Text(
                  widget.list[widget.index]['Nama'],
                  style: new TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                new Text(
                  "NIS : ${widget.list[widget.index]['NIS']}",
                  style: new TextStyle(fontSize: 20.0),
                ),
                new Text(
                  "Jenis Kelamin : ${widget.list[widget.index]['Jenis_Kelamin']}",
                  style: new TextStyle(fontSize: 20.0),
                ),
                new Text(
                  "Alamat : ${widget.list[widget.index]['Alamat']}",
                  style: new TextStyle(fontSize: 20.0),
                ),
                new Text(
                  "Nomor HP : ${widget.list[widget.index]['Nomor_HP']}",
                  style: new TextStyle(fontSize: 20.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new ElevatedButton(
                      child: new Text(
                        "Edit",
                        style: new TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new EditData(
                            list: widget.list,
                            index: widget.index,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    new ElevatedButton(
                      child: new Text(
                        "Delete",
                        style: new TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () => confirm(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
