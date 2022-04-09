class Street {
  late final int id;
  late final String street;
  late final String districtId;

  Street({
    required this.street,
    required this.districtId,
  });

  Street.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    street = json['street'];
    districtId = json['districtId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['street'] = street;
    _data['districtId'] = districtId;
    return _data;
  }

  @override
  String toString() => "Calle: $id, $street, $districtId";
}
