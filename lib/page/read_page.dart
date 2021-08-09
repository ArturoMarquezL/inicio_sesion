import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReadPage extends StatefulWidget {
  ReadPage({Key key}) : super(key: key);

  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  List<String> items = [];
  bool reading = true;

  Future<void> readData() async {
    try {
      var url = Uri.parse(
          "https://project-4ee6a-default-rtdb.firebaseio.com/agenda.json");
      var response = await http.get(url);
      var data = json.decode(response.body);

      items.clear();
      data.forEach((key, value) {
        items.add(value["nombre"]);
        items.add(value["email"]);
      });
      setState(() {
        reading = false;
      });
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos'),
      ),
      
        
        body:  ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Text(items[index]),
                  );
                }),
        floatingActionButton: Row(
        children : [
          SizedBox(
            height: 150,
            width: 150,
          ),
            FloatingActionButton.extended(
              label: Text('Registros'),
              onPressed: () {
                setState(() {
                  _read();
                  print("Data $_read");
                });
              },
            ),
            FloatingActionButton.extended(
                label: Text('Registrarse'),
                onPressed: () {
                  Navigator.pushNamed(context, 'write');
                }),
          ],
        ),
      );
  }

  void _read() {
    readData();
  }
}
