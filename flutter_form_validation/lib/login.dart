import 'package:flutter/material.dart';
import 'package:flutter_form_validation/Formulario.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

final _formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      backgroundColor: Colors.white70,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: Column(
            children: const [
              Text(
                'Hola de nuevo!\n',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Bienvenido de nuevo, te\n echabamos de menos!\n',
                style: TextStyle(color: Colors.white60, fontSize: 18),
              ),
              Formulario(),
            ],
          ),
        ),
      ),
    );
  }
}
