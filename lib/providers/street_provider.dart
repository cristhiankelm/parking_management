import 'dart:convert';

import 'package:http/http.dart';
import 'package:parking_management/models/city_model.dart';
import 'package:parking_management/models/district_model.dart';
import 'package:parking_management/models/state_model.dart';
import 'package:parking_management/models/street_model.dart';
import 'package:parking_management/services/auth_service.dart';
import 'package:parking_management/services/street_service.dart';

class StreetProvider {
  List<Street> streets = [];
  List<City> cities = [];
  List<District> districts = [];
  List<Department> states = [];
  List<Street> listStreets = [];
  List<City> listCities = [];
  List<District> listDistricts = [];
  List<Department> listStates = [];
  Street? street;
  District? district;
  Department? state;
  City? city;

  AuthService authService = AuthService();
  StreetService service = StreetService();

  var status;

  filterDistricts() {
    for (var i = 0; i < districts.length; i++) {
      if (districts[i].cityId == city!.id) {
        listDistricts.add(districts[i]);
      }
    }
  }

  filterStreets() {
    for (var i = 0; i < streets.length; i++) {
      if (streets[i].district!.id == district!.id) {
        listStreets.add(streets[i]);
      }
    }
  }

  filterCities() {
    for (var i = 0; i < cities.length; i++) {
      if (cities[i].stateId == state!.id) {
        listCities.add(cities[i]);
      }
    }
  }

  Future completeStreets(String currentToken) async {
    Response response = await service.getAllStreets(currentToken);
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      if (response.statusCode == 200) {
        Map<String, dynamic> map = Map.castFrom(data);
        for (var i = 0; i < map['data'].length; i++) {
          streets.add(Street.fromJson(map['data'][i]));
        }
      }
    }
  }

  Future completeStates(String currentToken) async {
    Response response = await service.getAllStates(currentToken);
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      if (response.statusCode == 200) {
        Map<String, dynamic> map = Map.castFrom(data);
        for (var i = 0; i < map['data'].length; i++) {
          states.add(Department.fromJson(map['data'][i]));
        }
      }
    }
  }

  Future completeCities(String currentToken) async {
    Response response = await service.getAllCities(currentToken);
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      if (response.statusCode == 200) {
        Map<String, dynamic> map = Map.castFrom(data);
        for (var i = 0; i < map['data'].length; i++) {
          if (state != null) {
            if (map['data'][i]['departments'][0]['id'] == state!.id) {
              cities.add(City.fromJson(map['data'][i]));
            }
          } else {
            cities.add(City.fromJson(map['data'][i]));
          }
        }
      }
    }
  }

  Future completeDistricts(String currentToken) async {
    Response response = await service.getAllDistricts(currentToken);
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      if (response.statusCode == 200) {
        Map<String, dynamic> map = Map.castFrom(json.decode(response.body));
        for (var i = 0; i < map['data'].length; i++) {
          if (city != null) {
            if (map['data'][i]['city'][0]['id'] == city!.id) {
              districts.add(District.fromJson(map['data'][i]));
            }
          } else {
            districts.add(District.fromJson(map['data'][i]));
          }
        }
      }
    }
  }

  Future<bool> addDistrict(District district, String currentToken) async {
    Response response = await service.createDistrict(district, currentToken);
    status = response.body.contains('error');

    if (status) {
      return false;
    } else {
      if (response.statusCode == 201) {
        Map<String, dynamic> map = Map.castFrom(json.decode(response.body));
        districts.add(District.fromJson(map['data']));
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> addStreet(Street street, String currentToken) async {
    Response response = await service.createStreet(street, currentToken);
    status = response.body.contains('error');

    if (status) {
      return false;
    } else {
      if (response.statusCode == 201) {
        Map<String, dynamic> map = Map.castFrom(json.decode(response.body));
        streets.add(Street.fromJson(map['data']));
        return true;
      } else {
        return false;
      }
    }
  }
}
