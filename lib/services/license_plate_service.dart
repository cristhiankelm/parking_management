import 'package:http/http.dart' as http;
import 'package:parking_management/models/licenseplate_model.dart';

class LicenseService {
  Future<http.Response> createLicense(
      LicensePlate licensePlate, String token) async {
    var url = "https://cristhiankelm.me/api/carIdentity/create";
    var response = await http.post(Uri.parse(url),
        body: licensePlate.toJson(),
        headers: {'Authorization': 'Bearer ' + token});
    return response;
  }

  Future<http.Response> getAllLicenses(String token) async {
    var url = "https://cristhiankelm.me/api/carIdentities";
    var response = http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer ' + token},
    );
    return response;
  }

  Future<http.Response> removeLicense(String token, int id) async {
    var url = "https://cristhiankelm.me/api/carIdentity/$id";
    var response = http.delete(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer ' + token},
    );
    return response;
  }
}
