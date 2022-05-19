import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_network_flutter/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  final String title = 'Login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';

  void signIn() async {
    String api = 'https://social-network-for-class.herokuapp.com/auth/login';

    Response response = await post(
      Uri.parse(api),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{'email': _email, 'password': _password}),
    );
    
    if (response.statusCode == 201) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      showDialog(context: context, builder: (context) =>
        AlertDialog(
          title: const Text('Login ou senha inválido(a)!'),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child:TextFormField(
                onChanged: (text) {
                  setState(() {
                    _email = text;
                  });
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Informe o e-mail:',
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child:TextFormField(
                obscureText: true,
                onChanged: (text) {
                  setState(() {
                    _password = text;
                  });
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Informe a senha:',
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextButton(
                onPressed: () {
                  signIn();
                },
                child: const Text('Entrar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
