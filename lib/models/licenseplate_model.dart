import 'package:parking_management/models/street_model.dart';

class LicensePlate {
  int? id;
  String? enroliment;
  Street? street;

  LicensePlate({this.id, required this.enroliment, this.street});

  LicensePlate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enroliment = json['enroliment'];
    street!.id = json['street'][0]['id'];
    street!.name = json['street'][0]['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['enroliment'] = enroliment;
    data['street_id'] = street!.id;
    return data;
  }

  @override
  String toString() => "$enroliment";
}
