class City {
  late int id;
  late String? name;
  late int? stateId;

  City({
    this.name,
    this.stateId,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['departments'][0]['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['departments_id'] = stateId;
    return data;
  }

  @override
  String toString() {
    return name!;
  }
}
