import 'package:http/http.dart' as http;
import 'package:parking_management/models/licenseplate_model.dart';

class LicenseService {
  String serverUrl = "http://smi-cloud.net/api";
  Future<http.Response> createLicense(
      LicensePlate licensePlate, String token) async {
    var url = "$serverUrl/carIdentity/create";
    var response = await http.post(Uri.parse(url),
        body: licensePlate.toJson(),
        headers: {'Authorization': 'Bearer ' + token});
    return response;
  }

  Future<http.Response> getAllLicenses(String token) async {
    var url = "$serverUrl/carIdentities";
    var response = http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer ' + token},
    );
    return response;
  }

  Future<http.Response> removeLicense(String token, int id) async {
    var url = "$serverUrl/carIdentity/$id";
    var response = http.delete(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer ' + token},
    );
    return response;
  }
}
