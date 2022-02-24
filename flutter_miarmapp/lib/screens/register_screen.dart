import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _userController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _repeatpasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _userController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _repeatpasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _userController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _repeatpasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: SizedBox(
                      width: 300,
                      height: 600,
                      child: Column(
                        children: [
                          const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Miarmapp',
                                style: TextStyle(
                                    fontFamily: 'miarmapp',
                                    color: Colors.black,
                                    fontSize: 40),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: 50,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nombre de usuario'),
                                controller: _userController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Introduzca datos validos porfavor';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: 50,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Correo electronico'),
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Introduzca datos validos';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: 50,
                              child: TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Contraseña'),
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Introduzca datos validos';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: 50,
                              child: TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Repetir contraseña'),
                                controller: _repeatpasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Introduzca datos validos';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: 30,
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Iniciando sesión')),
                                      );
                                      Navigator.pushNamed(context, '/');
                                    }
                                  },
                                  child: Text('Siguiente')),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: const Divider(
                              height: 60,
                              thickness: 3,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.facebook,
                                  color: Colors.blue,
                                ),
                                Text(
                                  ' Iniciar sesión con Facebook',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent),
                                )
                              ],
                            ),
                          ),
                          const Center(
                            child: Text(
                              '\nAl registrarte, aceptas nuestras Condiciones. Obtén más información sobre cómo recopilamos, usamos y compartimos tu información en la Política de datos, así como el uso que hacemos de las cookies y tecnologías similares en nuestra Política de cookies.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 65, right: 65, top: 10, bottom: 10),
                    child: RichText(
                      text: TextSpan(
                          text: '¿Tienes una cuenta?',
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Entrar',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue))
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
