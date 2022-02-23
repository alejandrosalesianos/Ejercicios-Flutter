import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/bloc_posts/bloc_posts_bloc.dart';
import 'package:flutter_miarmapp/model/post_response.dart';
import 'package:flutter_miarmapp/repository/post_repository.dart';
import 'package:flutter_miarmapp/repository/post_repository_impl.dart';
import 'package:flutter_miarmapp/widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostRepository postRepository;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Historias',
                  style: TextStyle(
                      color: Colors.black.withOpacity(.8),
                      fontWeight: FontWeight.w600,
                      fontSize: 19),
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.arrow_right,
                      size: 43,
                    ),
                    Text(
                      'Ver Todas',
                      style: TextStyle(
                          color: Colors.black.withOpacity(.8),
                          fontWeight: FontWeight.w600,
                          fontSize: 19),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15),
            height: 122,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            width: 75,
                            height: 75,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/muramasa.png'),
                                    fit: BoxFit.cover)),
                          ),
                          Positioned(
                            bottom: 0,
                            right: -1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white)),
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Mi Historia',
                        style: TextStyle(
                            color: Colors.black.withOpacity(.8),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                story(
                  'assets/images/muramasa.png',
                  'Muramasa',
                ),
                story(
                  'assets/images/muramasa.png',
                  'Muramasa',
                ),
                story('assets/images/muramasa.png', 'Muramasa'),
              ],
            ),
          ),
          BlocProvider(
            create: (context) {
              return BlocPostsBloc(postRepository)..add(FetchPosts());
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 358,
              child: _createPosts(context),
            ),
          )
        ],
      ),
    );
  }

  _createPosts(BuildContext context) {
    return BlocBuilder<BlocPostsBloc, BlocPostsState>(
        builder: (context, state) {
      if (state is BlocPostsInitial) {
        return const CircularProgressIndicator();
      } else if (state is BlocPostsFetchedError) {
        return Text('Fallo al cargar los datos');
      } else if (state is BlocPostsFetched) {
        return _buildPosts(context, state.posts);
      } else {
        return const Text('No soportado');
      }
    });
  }

  _buildPosts(BuildContext context, List<Post> posts) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _buildPostItem(posts[index]);
          },
          itemCount: posts.length,
        ));
  }

  _buildPostItem(Post post) {
    String urlFoto =
        post.contenidoMultimedia.replaceAll("localhost", "10.0.2.2");
    String urlAvatar = post.avatarUser.replaceAll("localhost", "10.0.2.2");
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.withOpacity(.3)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(urlAvatar),
            ),
            title: Text(
              post.titulo,
              style: TextStyle(
                  color: Colors.black.withOpacity(.8),
                  fontWeight: FontWeight.w400,
                  fontSize: 21),
            ),
            trailing: const Icon(Icons.more_vert),
          ),
          Image.network(
            urlFoto,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    Icon(Icons.favorite_border, size: 31),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.comment_sharp, size: 31),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.send, size: 31),
                  ],
                ),
                const Icon(Icons.bookmark_border, size: 31)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Text(
              'Les ha gustado esta publicación',
              style:
                  TextStyle(fontSize: 16, color: Colors.black.withOpacity(.8)),
            ),
          )
        ],
      ),
    );
  }
}

Widget story(String image, name) {
  return Padding(
    padding: const EdgeInsets.only(right: 12),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(0.1),
          width: 76,
          height: 76,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: Color.fromARGB(213, 194, 24, 132), width: 3)),
          child: ClipOval(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(
              color: Colors.black.withOpacity(.8), fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}

/*Widget post(String image, name) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(.3)))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/muramasa.png'),
          ),
          title: Text(
            name,
            style: TextStyle(
                color: Colors.black.withOpacity(.8),
                fontWeight: FontWeight.w400,
                fontSize: 21),
          ),
          trailing: const Icon(Icons.more_vert),
        ),
        Image.asset(
          image,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: const <Widget>[
                  Icon(Icons.favorite_border, size: 31),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(Icons.comment_sharp, size: 31),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(Icons.send, size: 31),
                ],
              ),
              const Icon(Icons.bookmark_border, size: 31)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            'Les ha gustado esta publicación',
            style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(.8)),
          ),
        )
      ],
    ),
  );
}*/
