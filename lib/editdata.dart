import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({required this.list, required this.index});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  late TextEditingController controllerNIS;
  late TextEditingController controllerNama;
  String? _selectedJenisKelamin; 
  late TextEditingController controllerAlamat;
  late TextEditingController controllerNomorHP;

  void editData() {
    var url = Uri.parse("http://10.0.2.2/my_store/editdata.php");

    http.post(url, body: {
      "ID": widget.list[widget.index]['ID'],
      "NIS": controllerNIS.text,
      "Nama": controllerNama.text,
      "Jenis_Kelamin": _selectedJenisKelamin,
      "Alamat": controllerAlamat.text,
      "Nomor_HP": controllerNomorHP.text
    });
  }

  @override
  void initState() {
    controllerNIS = new TextEditingController(text: widget.list[widget.index]['NIS']);
    controllerNama = new TextEditingController(text: widget.list[widget.index]['Nama']);
    _selectedJenisKelamin = widget.list[widget.index]['Jenis_Kelamin'];
    controllerAlamat = new TextEditingController(text: widget.list[widget.index]['Alamat']);
    controllerNomorHP =new TextEditingController(text: widget.list[widget.index]['Nomor_HP']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: new Column(
          children: <Widget>[
            new TextField(
              controller: controllerNIS,
              decoration: new InputDecoration(
                hintText: "Ketik NIS...",
                labelText: "NIS",
              ),
            ),
            new TextField(
              controller: controllerNama,
              decoration: new InputDecoration(
                hintText: "Ketik Nama...",
                labelText: "Nama",
              ),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Jenis Kelamin",
              ),
              value: _selectedJenisKelamin,
              items: ["Laki-Laki", "Perempuan"].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (newValue){
                setState(() {
                  _selectedJenisKelamin = newValue;
                });
              },
            ),
            new TextField(
              controller: controllerAlamat,
              decoration: new InputDecoration(
                hintText: "Ketik Alamat...",
                labelText: "Alamat",
              ),
            ),
            new TextField(
              controller: controllerNomorHP,
              decoration: new InputDecoration(
                hintText: "Ketik Nomor Hp...",
                labelText: "Nomor HP",
              ),
            ),
            new Padding(padding: const EdgeInsets.all(10.0)),
            new ElevatedButton(
              child: new Text(
                "Edit",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () {
                editData();
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new Home()
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
