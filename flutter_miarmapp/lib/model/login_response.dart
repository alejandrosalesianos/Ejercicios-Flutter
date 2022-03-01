class LoginResponse {
  LoginResponse({
    required this.email,
    required this.nick,
    required this.avatar,
    required this.perfil,
    required this.token,
    required this.posts,
  });
  late final String email;
  late final String nick;
  late final String avatar;
  late final String perfil;
  late final String token;
  late final List<Posts> posts;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    nick = json['nick'];
    avatar = json['avatar'];
    perfil = json['perfil'];
    token = json['token'];
    posts = List.from(json['posts']).map((e) => Posts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['nick'] = nick;
    _data['avatar'] = avatar;
    _data['perfil'] = perfil;
    _data['token'] = token;
    _data['posts'] = posts.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Posts {
  Posts({
    required this.id,
    required this.titulo,
    required this.contenido,
    required this.contenidoOriginal,
    required this.contenidoMultimedia,
    required this.tipoPublicacion,
    required this.user,
    this.avatarUser,
  });
  late final int id;
  late final String titulo;
  late final String contenido;
  late final String contenidoOriginal;
  late final String contenidoMultimedia;
  late final String tipoPublicacion;
  late final String user;
  late final Null avatarUser;

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    contenido = json['contenido'];
    contenidoOriginal = json['contenidoOriginal'];
    contenidoMultimedia = json['contenidoMultimedia'];
    tipoPublicacion = json['tipoPublicacion'];
    user = json['user'];
    avatarUser = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['titulo'] = titulo;
    _data['contenido'] = contenido;
    _data['contenidoOriginal'] = contenidoOriginal;
    _data['contenidoMultimedia'] = contenidoMultimedia;
    _data['tipoPublicacion'] = tipoPublicacion;
    _data['user'] = user;
    _data['avatarUser'] = avatarUser;
    return _data;
  }
}
