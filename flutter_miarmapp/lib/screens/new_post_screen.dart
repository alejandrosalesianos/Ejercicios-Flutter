import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/bloc_posts/bloc_posts_bloc.dart';
import 'package:flutter_miarmapp/model/post_dto.dart';
import 'package:flutter_miarmapp/repository/post_repository.dart';
import 'package:flutter_miarmapp/repository/post_repository_impl.dart';
import 'package:flutter_miarmapp/screens/menu_screen.dart';
import 'package:image_picker/image_picker.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  late PostRepository postRepository;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tituloController;
  late TextEditingController _contenidoController;
  late String path = '';
  String tipoPerfil = 'PUBLICA';

  @override
  void initState() {
    super.initState();
    postRepository = PostRepositoryImpl();
    _tituloController = TextEditingController();
    _contenidoController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return BlocPostsBloc(postRepository);
        },
        child: BlocConsumer<BlocPostsBloc, BlocPostsState>(
          listenWhen: (context, state) {
            return state is ImageSelectedPostSuccessState;
          },
          listener: (context, state) {
            if (state is NewPostSuccessState) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MenuScreen()));
            } else if (state is NewPostErrorState) {
              _showSnackBar(context, state.message);
            }
          },
          buildWhen: (context, state) {
            return state is BlocPostsInitial ||
                state is ImageSelectedPostSuccessState ||
                state is NewPostLoadingState;
          },
          builder: (context, state) {
            if (state is ImageSelectedPostSuccessState) {
              path = state.SelectedFile.path;
              return formBuilder(context, path);
            } else if (state is NewPostLoadingState) {
              Navigator.pushNamed(context, '/');
            }
            return formBuilderWithoutImage(context);
          },
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {}

  Widget formBuilder(BuildContext context, String path) {
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
                      height: 500,
                      child: Column(children: [
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
                                  labelText: 'Titulo de la Publicación'),
                              controller: _tituloController,
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
                                  labelText: 'Contenido'),
                              controller: _contenidoController,
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
                          child: Text(
                            'Visibilidad del perfil',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        DropdownButton(
                            items: [
                              DropdownMenuItem(
                                child: Text('Pública'),
                                value: 'PUBLICA',
                              ),
                              DropdownMenuItem(
                                child: Text('Privada'),
                                value: 'PRIVADA',
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
                                    final postDto = PostDto(
                                        contenido: _contenidoController.text,
                                        tipoPublicacion: tipoPerfil,
                                        titulo: _tituloController.text);
                                    BlocProvider.of<BlocPostsBloc>(context)
                                        .add(SavePostEvent(postDto, path));
                                  }
                                },
                                child: Text('Siguiente')),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget formBuilderWithoutImage(BuildContext context) {
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
                      height: 400,
                      child: Column(children: [
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
                                  labelText: 'Titulo de la Publicación'),
                              controller: _tituloController,
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
                                  labelText: 'Contenido'),
                              controller: _contenidoController,
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
                          child: Text(
                            'Visibilidad del perfil',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        DropdownButton(
                            items: [
                              DropdownMenuItem(
                                child: Text('Pública'),
                                value: 'PUBLICA',
                              ),
                              DropdownMenuItem(
                                child: Text('Privada'),
                                value: 'PRIVADA',
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
                              BlocProvider.of<BlocPostsBloc>(context).add(
                                  const SelectImagePostEvent(
                                      ImageSource.gallery));
                            },
                            child: const Text('Seleccionar imagen'),
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
                                    final postDto = PostDto(
                                        contenido: _contenidoController.text,
                                        tipoPublicacion: tipoPerfil,
                                        titulo: _tituloController.text);
                                    BlocProvider.of<BlocPostsBloc>(context)
                                        .add(SavePostEvent(postDto, path));
                                  }
                                },
                                child: Text('Siguiente')),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
