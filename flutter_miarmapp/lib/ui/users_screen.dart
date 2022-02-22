import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/bloc_users/user_bloc.dart';
import 'package:flutter_miarmapp/repository/user_repository.dart';
import 'package:flutter_miarmapp/repository/user_repository_impl.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late UserRepository userRepository;

  @override
  void initState() {
    super.initState();
    userRepository = UserRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UserBloc(userRepository)
          ..add(FetchUserWithNameEvent('Username del tio'));
      },
      child: _users(context),
    );
  }

  _users(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserInitial) {
        return CircularProgressIndicator();
      } else if (state is UserFetched) {
        return _buildUserList(state.listUser);
      } else if (state is UserFetchError) {
        return Text(state.message);
      }
      return CircularProgressIndicator();
    });
  }

  _buildUserList(List<Object> listUser) {
    return ListView.builder(
        itemCount: listUser.length,
        itemBuilder: (context, index) {
          return _userItemBuilder(listUser.elementAt(index));
        });
  }

  _userItemBuilder(Object elementAt) {}
}
