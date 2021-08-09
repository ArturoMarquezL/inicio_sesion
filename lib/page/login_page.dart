import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String email;
  String password;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: _loginForm(),
    );
  }

  Widget _loginForm() {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      children: [
        Text('Email'),
        Icon(Icons.email),
        TextField(
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
        ),
        Text('Password'),
        Icon(Icons.vpn_key),
        TextField(
          controller: _passwordController,
          obscureText: true,
        ),
        ElevatedButton(onPressed: _getValues, child: Text('Login'))
      ],
    );
  }

  void _getValues() {
    setState(() {
      email = _emailController.text;
      password = _passwordController.text;
      authUser(email, password);
    });
  }

  void _alert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('¡Incorrecto!'),
            content: Text('Tu correo o contraseña no coinciden'),
          );
        });
  }

  void authUser(String email, String password) async {
    try {
      var url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCSKfgWP7yh02MTTSdO6bEEvCxq1ccybNM');
      Map<String, dynamic> map = new Map<String, dynamic>();
      map['email'] = email;
      map['password'] = password;
      var response = await http.post(url, body: map);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        Navigator.popAndPushNamed(context, 'read');
      }
      if (response.statusCode == 400) {
        _alert();
      }
    } catch (error) {
      print(error.toString());
    }
  }


}
