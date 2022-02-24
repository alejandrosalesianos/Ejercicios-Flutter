import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/bloc_users/user_bloc.dart';
import 'package:flutter_miarmapp/model/my_user_response.dart';
import 'package:flutter_miarmapp/repository/user_repository.dart';
import 'package:flutter_miarmapp/repository/user_repository_impl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  late UserRepository userRepository;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    userRepository = UserRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocProvider(
            create: (context) {
              return UserBloc(userRepository)..add(FetchUsersEvent());
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 360,
              child: _createUserDetail(context),
            ),
          ),
          SizedBox(
            height: 70,
            child: TabBar(
              indicatorColor: Colors.grey,
              controller: tabController,
              tabs: const [
                Tab(
                    icon: Icon(
                  Icons.table_chart_outlined,
                  color: Colors.grey,
                )),
                Tab(
                    icon: Icon(
                  Icons.person_pin_outlined,
                  color: Colors.grey,
                )),
              ],
            ),
          ),
          SizedBox(
            height: 150.0,
            child: TabBarView(
              controller: tabController,
              children: [
                BlocProvider(
                  create: (context) {
                    return UserBloc(userRepository)..add(FetchUsersEvent());
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 200,
                    child: _createPostsUser(context),
                  ),
                ),
                Text('Tab 2')
              ],
            ),
          ),
        ],
      ),
    );
  }

  _createPostsUser(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is UserFetched) {
        return _buildPostsUser(context, state.user);
      } else {
        return const Text('No soportado');
      }
    });
  }

  _buildPostsUser(BuildContext context, MyUserResponse user) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(user.posts.length, (index) {
          String urlPost = user.posts
              .elementAt(index)
              .contenidoMultimedia
              .replaceAll("localhost", "10.0.2.2");
          return SizedBox(
            width: 50,
            height: 80,
            child: Image.network(
              '${urlPost}',
              fit: BoxFit.fill,
            ),
          );
        }),
      ),
    );
  }

  _createUserDetail(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is UserFetched) {
        return _buildUserDetail(context, state.user);
      } else {
        return const Text('No soportado');
      }
    });
  }

  _buildUserDetail(BuildContext context, MyUserResponse user) {
    String urlAvatar = user.avatar.replaceAll("localhost", "10.0.2.2");
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(Icons.lock),
                    SizedBox(width: 4.0),
                    Text(
                      "${user.username}",
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 254, 254)),
                    ),
                    SizedBox(width: 12.0),
                    Container(
                      alignment: Alignment.center,
                      width: 35.0,
                      height: 25.0,
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.add_box_outlined),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.menu),
                      )
                    ],
                  ))
            ],
          )),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(urlAvatar))),
                          ),
                          Column(
                            children: [
                              Text(
                                "${user.posts.length}",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                "Posts",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "${user.followers.length}",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                "Seguidores",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "0",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                "Seguidos",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${user.username}",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0))),
                            ])),
                    SizedBox(height: 12.0),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 350.0,
                              height: 35.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  width: 2.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              child: Text("Editar Perfil",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0))),
                            ),
                            Icon(Icons.expand_more_outlined,
                                color: Color.fromARGB(255, 0, 0, 0))
                          ]),
                    ),
                    SizedBox(height: 24.0),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 350.0,
                              height: 35.0,
                              child: const Text("Historias Destacadas",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold)),
                            ),
                            Icon(Icons.expand_more_outlined,
                                color: Color.fromARGB(255, 0, 0, 0))
                          ]),
                    ),
                    Divider(
                      color: Colors.grey[800],
                      thickness: 2.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
*/
