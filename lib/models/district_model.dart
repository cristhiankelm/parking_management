class District {
  int? id;
  String? cityId;
  String? district;

  District({
    this.id,
    this.cityId,
    this.district,
  });

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['cityId'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cityId'] = cityId;
    data['district'] = district;
    return data;
  }

  @override
  String toString() => "Barrio: $id, $district, $cityId";
}
