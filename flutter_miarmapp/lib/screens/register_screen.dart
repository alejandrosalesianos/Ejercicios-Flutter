import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/bloc_image_pick/image_pick_bloc.dart';
import 'package:flutter_miarmapp/model/register_dto.dart';
import 'package:flutter_miarmapp/repository/register_repository.dart';
import 'package:flutter_miarmapp/repository/register_repository_impl.dart';
import 'package:flutter_miarmapp/screens/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'menu_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _telefonoController;
  late TextEditingController _userController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _repeatpasswordController;
  late RegisterRepository registerRepository;
  DateTime selectedDate = DateTime.now();
  String tipoPerfil = "PUBLICO";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    registerRepository = RegisterRepositoryImpl();
    _userController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _repeatpasswordController = TextEditingController();
    _telefonoController = TextEditingController();
    _userController.text = "V de Vicente";
    _emailController.text = "V@Gmail.com";
    _passwordController.text = "Pingo123";
    _repeatpasswordController.text = "Pingo123";
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
        body: BlocProvider(
      create: (context) {
        return ImagePickBloc(registerRepository);
      },
      child: BlocConsumer<ImagePickBloc, ImagePickState>(
        listenWhen: (context, state) {
          return state is ImageSelecedSuccessState;
        },
        listener: (context, state) async {
          if (state is RegisterSucessState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MenuScreen()));
          } else if (state is RegisterErrorState) {
            _showSnackbar(context, state.message);
          }
        },
        buildWhen: (context, state) {
          return state is ImagePickInitial ||
              state is ImageSelecedSuccessState ||
              state is SaveLoadingState;
        },
        builder: (context, state) {
          if (state is ImageSelecedSuccessState) {
            String path = state.SelectedFile.path;
            return formWithImage(context, path);
          } else if (state is SaveLoadingState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          }
          return form(context);
        },
      ),
    ));
  }

  Widget form(BuildContext context) {
    return SingleChildScrollView(
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
                    height: 810,
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
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xfff1f1f5),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: 50,
                              child: DateTimeFormField(
                                initialDate: DateTime(2001, 9, 7),
                                firstDate: DateTime.utc(1900),
                                lastDate: DateTime.now(),
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(color: Colors.black45),
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent),
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.event_note),
                                  labelText: 'Select Birth Day',
                                ),
                                mode: DateTimeFieldPickerMode.date,
                                autovalidateMode: AutovalidateMode.always,
                                validator: (e) => (e?.day ?? 0) == 1
                                    ? 'Please not the first day'
                                    : null,
                                onDateSelected: (DateTime value) {
                                  selectedDate = value;
                                },
                              ),
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
                                    labelText: 'Teléfono'),
                                controller: _telefonoController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Visibilidad del perfil',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        DropdownButton(
                            items: [
                              DropdownMenuItem(
                                child: Text('Público'),
                                value: 'PUBLICO',
                              ),
                              DropdownMenuItem(
                                child: Text('Privado'),
                                value: 'PRIVADO',
                              )
                            ],
                            value: tipoPerfil,
                            onChanged: (String? value) {
                              setState(() {
                                tipoPerfil = value!;
                              });
                            }),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<ImagePickBloc>(context).add(
                                  const SelectImageEvent(ImageSource.gallery));
                            },
                            child: const Text('Seleccionar imagen'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: 30,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final registerDto = RegisterDto(
                                        nick: _userController.text,
                                        email: _emailController.text,
                                        fechaNacimiento:
                                            DateFormat("dd-MM-yyyy")
                                                .format(selectedDate),
                                        telefono: _telefonoController.text,
                                        perfil: tipoPerfil,
                                        password: _passwordController.text,
                                        password2:
                                            _repeatpasswordController.text);
                                    BlocProvider.of<ImagePickBloc>(context)
                                        .add(SaveUserEvent(registerDto, ''));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Iniciando sesión')),
                                    );
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
    );
  }

  Widget formWithImage(BuildContext context, String path) {
    return SingleChildScrollView(
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
                    height: 930,
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
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xfff1f1f5),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: 50,
                              child: DateTimeFormField(
                                initialDate: DateTime(2001, 9, 7),
                                firstDate: DateTime.utc(1900),
                                lastDate: DateTime.now(),
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(color: Colors.black45),
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent),
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.event_note),
                                  labelText: 'Select Birth Day',
                                ),
                                mode: DateTimeFieldPickerMode.date,
                                autovalidateMode: AutovalidateMode.always,
                                validator: (e) => (e?.day ?? 0) == 1
                                    ? 'Please not the first day'
                                    : null,
                                onDateSelected: (DateTime value) {
                                  selectedDate = value;
                                },
                              ),
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
                                    labelText: 'Teléfono'),
                                controller: _telefonoController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Visibilidad del perfil',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        DropdownButton(
                            items: [
                              DropdownMenuItem(
                                child: Text('Público'),
                                value: 'PUBLICO',
                              ),
                              DropdownMenuItem(
                                child: Text('Privado'),
                                value: 'PRIVADO',
                              )
                            ],
                            value: tipoPerfil,
                            onChanged: (String? value) {
                              setState(() {
                                tipoPerfil = value!;
                              });
                            }),
                        Container(
                          margin: EdgeInsets.all(20),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: FileImage(File(path)), fit: BoxFit.fill),
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
                                    final registerDto = RegisterDto(
                                        nick: _userController.text,
                                        email: _emailController.text,
                                        fechaNacimiento:
                                            DateFormat("dd-MM-yyyy")
                                                .format(selectedDate),
                                        telefono: _telefonoController.text,
                                        perfil: tipoPerfil,
                                        password: _passwordController.text,
                                        password2:
                                            _repeatpasswordController.text);
                                    BlocProvider.of<ImagePickBloc>(context)
                                        .add(SaveUserEvent(registerDto, path));
                                  }
                                },
                                child: Text('Registrarse')),
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
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
