class RegisterDto {
  RegisterDto({
    required this.nick,
    required this.email,
    required this.fechaNacimiento,
    required this.telefono,
    required this.perfil,
    required this.password,
    required this.password2,
  });
  late final String nick;
  late final String email;
  late final String fechaNacimiento;
  late final String telefono;
  late final String perfil;
  late final String password;
  late final String password2;
  
  RegisterDto.fromJson(Map<String, dynamic> json){
    nick = json['nick'];
    email = json['email'];
    fechaNacimiento = json['fechaNacimiento'];
    telefono = json['telefono'];
    perfil = json['perfil'];
    password = json['password'];
    password2 = json['password2'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nick'] = nick;
    _data['email'] = email;
    _data['fechaNacimiento'] = fechaNacimiento;
    _data['telefono'] = telefono;
    _data['perfil'] = perfil;
    _data['password'] = password;
    _data['password2'] = password2;
    return _data;
  }
}