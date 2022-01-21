class AmiiboResponse {
  AmiiboResponse({
    required this.amiibo,
  });
  late final List<Amiibo> amiibo;

  AmiiboResponse.fromJson(Map<String, dynamic> json) {
    amiibo = List.from(json['amiibo']).map((e) => Amiibo.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['amiibo'] = amiibo.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Amiibo {
  Amiibo({
    required this.amiiboSeries,
    required this.character,
    required this.gameSeries,
    required this.head,
    required this.image,
    required this.name,
    required this.release,
    required this.tail,
    required this.type,
  });
  late final String amiiboSeries;
  late final String character;
  late final String gameSeries;
  late final String head;
  late final String image;
  late final String name;
  late final Release? release;
  late final String tail;
  late final String type;

  Amiibo.fromJson(Map<String, dynamic> json) {
    amiiboSeries = json['amiiboSeries'];
    character = json['character'];
    gameSeries = json['gameSeries'];
    head = json['head'];
    image = json['image'];
    name = json['name'];
    release = Release.fromJson(json['release']);
    tail = json['tail'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['amiiboSeries'] = amiiboSeries;
    _data['character'] = character;
    _data['gameSeries'] = gameSeries;
    _data['head'] = head;
    _data['image'] = image;
    _data['name'] = name;
    _data['release'] = release?.toJson();
    _data['tail'] = tail;
    _data['type'] = type;
    return _data;
  }
}

class Release {
  Release({
    required this.au,
    required this.eu,
    required this.jp,
    required this.na,
  });
  late final String? au;
  late final String? eu;
  late final String? jp;
  late final String? na;

  Release.fromJson(Map<String, dynamic> json) {
    au = json['au'];
    eu = json['eu'];
    jp = json['jp'];
    na = json['na'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['au'] = au;
    _data['eu'] = eu;
    _data['jp'] = jp;
    _data['na'] = na;
    return _data;
  }
}
