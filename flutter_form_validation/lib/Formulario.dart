import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  const Formulario({Key? key}) : super(key: key);

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 70,
              width: 300,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0)))),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Introduzca Usuario'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 4) {
                      return 'Fallo en la validación no puede ser una contraseña vacia o menor de 4 caracteres.';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 70,
              width: 300,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0)))),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Contraseña'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 4) {
                      return 'Fallo en la validación no puede ser una contraseña vacia o menor de 4 caracteres.';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.only(left: 100, right: 100)),
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Datos correctos')));
                }
              },
              child: const Text('Log in'),
            ),
          ),
          RichText(text: const TextSpan(text: '\n¿Todavia no eres miembro?')),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                'Registrate',
                style: TextStyle(color: Colors.blue),
              ))
        ],
      ),
    );
  }
}
