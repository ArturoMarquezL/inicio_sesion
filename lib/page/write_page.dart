import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WritePage extends StatefulWidget {
  WritePage({Key key}) : super(key: key);

  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final _emailController = TextEditingController();
  final _nombreController = TextEditingController();
  String email;
  String nombre;

  @override
  void dispose() {
    _emailController.dispose();
    _nombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        
      ),
      body: _formPersonas(),
    );
  }

  _formPersonas() {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        Text('nombre'),
        TextField(
          controller: _nombreController,
        ),
        Text('email'),
        TextField(
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
        ),
        ElevatedButton(onPressed: _getData, child: Text('Enviar'))
      ],
    );
  }

  void _getData() {
    setState(() {
      nombre = _nombreController.text;
      email = _emailController.text;
      _postData(nombre, email);
    });
  }

  void _postData(String nombre, String email) async {
    try {
      var url = Uri.parse(
          "https://project-4ee6a-default-rtdb.firebaseio.com/agenda.json");

      var data = {'nombre': nombre, 'email': email};
      final response = await http.post(url, body: json.encode(data));
      if (response.statusCode == 200) {

      }
    } catch (error) {
      print(error.toString());
    }
  }
}
