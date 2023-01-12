import 'package:parking_management/models/district_model.dart';
import 'package:parking_management/models/street_model.dart';
import 'package:http/http.dart' as http;

class StreetService {
  String serverUrl = "http://smi-cloud.net/api";
  Future<http.Response> getAllStates(String token) async {
    var url = "$serverUrl/departments";
    var response = http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer ' + token},
    );
    return response;
  }

  Future<http.Response> getAllCities(String token) async {
    var url = "$serverUrl/cities";
    var response = http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer ' + token},
    );
    return response;
  }

  Future<http.Response> getAllDistricts(String token) async {
    var url = "$serverUrl/neighborhoods";
    var response = http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer ' + token},
    );
    return response;
  }

  Future<http.Response> getAllStreets(String token) async {
    var url = "$serverUrl/streets";
    var response = http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer ' + token},
    );
    return response;
  }

  Future<http.Response> createDistrict(District district, String token) async {
    var url = "$serverUrl/neighborhood/create";
    var response = await http.post(Uri.parse(url),
        body: {'name': district.name, 'city_id': district.cityId.toString()},
        headers: {'Authorization': 'Bearer ' + token});
    return response;
  }

  Future<http.Response> createStreet(Street street, String token) async {
    var url = "$serverUrl/street/create";
    var response = await http.post(Uri.parse(url), body: {
      'name': street.name,
      'neighborhood_id': street.district!.id.toString()
    }, headers: {
      'Authorization': 'Bearer ' + token
    });
    return response;
  }
}
