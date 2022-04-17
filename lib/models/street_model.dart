import 'package:parking_management/models/city_model.dart';
import 'package:parking_management/models/district_model.dart';
import 'package:parking_management/models/state_model.dart';

class Street {
  late int id;
  late String? name;
  late District? district = District();
  late City city = City();
  late Department state = Department();

  Street({this.name, this.district});

  Street.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    district!.id = json['neighborhood'][0]['id'];
    district!.name = json['neighborhood'][0]['name'];
    city.name = json['neighborhood'][0]['city'][0]['name'];
    state.name = json['neighborhood'][0]['city'][0]['departments'][0]['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['street'] = name;
    data['neighborhood_id'] = district!.id;
    return data;
  }

  @override
  String toString() => "$name, ${district!.name}, ${city.name}, ${state.name}";
}
