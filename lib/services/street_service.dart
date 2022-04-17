import 'package:parking_management/models/district_model.dart';
import 'package:parking_management/models/street_model.dart';
import 'package:http/http.dart' as http;

class StreetService {
  Future<http.Response> getAllStates(String token) async {
    var url = "https://cristhiankelm.me/api/departments";
    var response = http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer ' + token},
    );
    return response;
  }

  Future<http.Response> getAllCities(String token) async {
    var url = "https://cristhiankelm.me/api/cities";
    var response = http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer ' + token},
    );
    return response;
  }

  Future<http.Response> getAllDistricts(String token) async {
    var url = "https://cristhiankelm.me/api/neighborhoods";
    var response = http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer ' + token},
    );
    return response;
  }

  Future<http.Response> getAllStreets(String token) async {
    var url = "https://cristhiankelm.me/api/streets";
    var response = http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer ' + token},
    );
    return response;
  }

  Future<http.Response> createDistrict(District district, String token) async {
    var url = "https://cristhiankelm.me/api/neighborhood/create";
    var response = await http.post(Uri.parse(url),
        body: {'name': district.name, 'city_id': district.cityId.toString()},
        headers: {'Authorization': 'Bearer ' + token});
    return response;
  }

  Future<http.Response> createStreet(Street street, String token) async {
    var url = "https://cristhiankelm.me/api/street/create";
    var response = await http.post(Uri.parse(url), body: {
      'name': street.name,
      'neighborhood_id': street.district!.id.toString()
    }, headers: {
      'Authorization': 'Bearer ' + token
    });
    return response;
  }
}
