import 'package:flutter/material.dart';
import 'package:flutter_form_validation/FormularioRegister.dart';

import 'Formulario.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
              FormularioRegister(),
            ],
          ),
        ),
      ),
    );
  }
}
