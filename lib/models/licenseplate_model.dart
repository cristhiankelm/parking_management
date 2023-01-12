class LicensePlate {
  late int? id;
  late String enroliment;
  String? street_id;

  LicensePlate({this.id, required this.enroliment, this.street_id});

  LicensePlate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enroliment = json['enrollment'];
    street_id = json['streets'][0]['id'].toString();
  }

  LicensePlate.fromJsonData(Map<String, dynamic> json) {
    id = json['data']['id'];
    enroliment = json['data']['enrollment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enrollment'] = enroliment;
    data['street_id'] = street_id;
    return data;
  }

  @override
  String toString() => enroliment;
}
