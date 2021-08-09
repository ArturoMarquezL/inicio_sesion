import 'package:flutter/material.dart';
import 'package:inicio_sesion/page/login_page.dart';
import 'package:inicio_sesion/page/read_page.dart';
import 'package:inicio_sesion/page/write_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.red,
      ),
       initialRoute: 'login',
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'read' :(BuildContext context) => ReadPage(),
        'write':(BuildContext context) => WritePage()
      },

    );
  }
}
