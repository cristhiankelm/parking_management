class District {
  late int id;
  late int? cityId;
  late String? name;

  District({
    this.cityId,
    this.name,
  });

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city'][0]['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['city_id'] = cityId;
    return data;
  }

  @override
  String toString() => "$name";
}
