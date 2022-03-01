class RegisterResponse {
  RegisterResponse({
    required this.id,
    required this.username,
    required this.email,
    required this.telefono,
    required this.avatar,
    required this.perfil,
    required this.fecha,
    required this.posts,
    required this.listaPeticiones,
    required this.followers,
  });
  late final String id;
  late final String username;
  late final String email;
  late final String telefono;
  late final String avatar;
  late final String perfil;
  late final String fecha;
  late final List<dynamic> posts;
  late final List<dynamic> listaPeticiones;
  late final List<dynamic> followers;
  
  RegisterResponse.fromJson(Map<String, dynamic> json){
    id = json['id'];
    username = json['username'];
    email = json['email'];
    telefono = json['telefono'];
    avatar = json['avatar'];
    perfil = json['perfil'];
    fecha = json['fecha'];
    posts = List.castFrom<dynamic, dynamic>(json['posts']);
    listaPeticiones = List.castFrom<dynamic, dynamic>(json['listaPeticiones']);
    followers = List.castFrom<dynamic, dynamic>(json['followers']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['email'] = email;
    _data['telefono'] = telefono;
    _data['avatar'] = avatar;
    _data['perfil'] = perfil;
    _data['fecha'] = fecha;
    _data['posts'] = posts;
    _data['listaPeticiones'] = listaPeticiones;
    _data['followers'] = followers;
    return _data;
  }
}