import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/bloc_posts/bloc_posts_bloc.dart';
import 'package:flutter_miarmapp/model/post_response.dart';
import 'package:flutter_miarmapp/repository/post_repository.dart';
import 'package:flutter_miarmapp/repository/post_repository_impl.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  late PostRepository postRepository;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    postRepository = PostRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                height: 50,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      labelText: 'Busca Publicaciones aqui'),
                ),
              ),
            ),
            BlocProvider(
              create: (context) {
                return BlocPostsBloc(postRepository)..add(FetchPosts());
              },
              child: Scaffold(
                body: _createPosts(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  _createPosts(BuildContext context) {
    return BlocBuilder<BlocPostsBloc, BlocPostsState>(
        builder: (context, state) {
      if (state is BlocPostsInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
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
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height - 50,
      child: ListView.builder(itemBuilder: (context, index) {
        return _buildPostItem(context, posts.elementAt(index));
      }),
    );
  }

  _buildPostItem(BuildContext context, Post post) {}
}
