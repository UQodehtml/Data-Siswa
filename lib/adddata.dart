import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerNIS = new TextEditingController();
  TextEditingController controllerNama = new TextEditingController();
  String? _selectedJenisKelamin;
  TextEditingController controllerAlamat = new TextEditingController();
  TextEditingController controllerNomorHP = new TextEditingController();

  void addData() {
    var url = Uri.parse("http://10.0.2.2/my_store/adddata.php");

    http.post(url, body: {
      "NIS": controllerNIS.text,
      "Nama": controllerNama.text,
      "Jenis_Kelamin": _selectedJenisKelamin,
      "Alamat": controllerAlamat.text,
      "Nomor_HP": controllerNomorHP.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tambah Data"),
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
              child: new Text("Tambah"),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () {
                addData();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
