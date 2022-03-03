class PostDto {
  PostDto({
    required this.titulo,
    required this.contenido,
    required this.tipoPublicacion,
  });
  late final String titulo;
  late final String contenido;
  late final String tipoPublicacion;
  
  PostDto.fromJson(Map<String, dynamic> json){
    titulo = json['titulo'];
    contenido = json['contenido'];
    tipoPublicacion = json['tipoPublicacion'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['titulo'] = titulo;
    _data['contenido'] = contenido;
    _data['tipoPublicacion'] = tipoPublicacion;
    return _data;
  }
}