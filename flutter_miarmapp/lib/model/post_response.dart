class PostResponse {
  PostResponse({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalElements,
    required this.totalPages,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });
  late final List<Post> content;
  late final String pageable;
  late final bool last;
  late final int totalElements;
  late final int totalPages;
  late final int size;
  late final int number;
  late final Sort sort;
  late final bool first;
  late final int numberOfElements;
  late final bool empty;

  PostResponse.fromJson(Map<String, dynamic> json) {
    content = List.from(json['content']).map((e) => Post.fromJson(e)).toList();
    pageable = json['pageable'];
    last = json['last'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    size = json['size'];
    number = json['number'];
    sort = Sort.fromJson(json['sort']);
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e) => e.toJson()).toList();
    _data['pageable'] = pageable;
    _data['last'] = last;
    _data['totalElements'] = totalElements;
    _data['totalPages'] = totalPages;
    _data['size'] = size;
    _data['number'] = number;
    _data['sort'] = sort.toJson();
    _data['first'] = first;
    _data['numberOfElements'] = numberOfElements;
    _data['empty'] = empty;
    return _data;
  }
}

class Post {
  Post({
    required this.id,
    required this.titulo,
    required this.contenido,
    required this.contenidoOriginal,
    required this.contenidoMultimedia,
    required this.tipoPublicacion,
    required this.user,
    required this.avatarUser,
  });
  late final int id;
  late final String titulo;
  late final String contenido;
  late final String contenidoOriginal;
  late final String contenidoMultimedia;
  late final String tipoPublicacion;
  late final String user;
  late final String avatarUser;

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    contenido = json['contenido'];
    contenidoOriginal = json['contenidoOriginal'];
    contenidoMultimedia = json['contenidoMultimedia'];
    tipoPublicacion = json['tipoPublicacion'];
    user = json['user'];
    avatarUser = json['avatarUser'];
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

class Sort {
  Sort({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });
  late final bool empty;
  late final bool sorted;
  late final bool unsorted;

  Sort.fromJson(Map<String, dynamic> json) {
    empty = json['empty'];
    sorted = json['sorted'];
    unsorted = json['unsorted'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['empty'] = empty;
    _data['sorted'] = sorted;
    _data['unsorted'] = unsorted;
    return _data;
  }
}
