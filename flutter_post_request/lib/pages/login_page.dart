import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_post_request/models/login_model.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<AuthResponse>? _futureAuth;
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: const Color(0xff0F7EDD),
          padding: const EdgeInsets.all(20),
          child:
              (_futureAuth == null) ? buildForm(context) : buildFutureBuilder(),
        ),
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png'),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.person),
                  suffixIconColor: Colors.white,
                  hintText: 'Username',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value == null || value.isEmpty)
                    ? 'No se admiten valores vacios'
                    : null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.email),
                  suffixIconColor: Colors.white,
                  hintText: 'Email',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value == null || !value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.vpn_key),
                  suffixIconColor: Colors.white,
                  hintText: 'Password',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (value) {
                return (value == null || value.isEmpty)
                    ? 'Write a password'
                    : null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Code',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value == null || !value.contains('UDEMYANDROID'))
                    ? 'No se admiten valores vacios o el codigo es incorrecto'
                    : null;
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _futureAuth = _doRegister(context);
                });
              }
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  'Sign In'.toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )),
          )
        ],
      ),
    );
  }

  FutureBuilder<AuthResponse> buildFutureBuilder() {
    return FutureBuilder<AuthResponse>(
      future: _futureAuth,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Text(snapshot.data!.username));
        } else if (snapshot.hasError) {
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Center(child: Text('${snapshot.error}')));
        }

        return const CircularProgressIndicator();
      },
    );
  }

  Future<AuthResponse> _doRegister(BuildContext context) async {
    RegisterDto _registerDto = RegisterDto(
        code: 'UDEMYANDROID',
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text);

    Map<String, String> headers = {'Content-Type': 'application/json'};

    final response = await http.post(
        Uri.parse('https://www.minitwitter.com:3001/apiv1/auth/signup'),
        headers: headers,
        body: jsonEncode(_registerDto.toJson()));

    print('CODE: ${response.statusCode}');
    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
