import 'package:http/http.dart' as http;
import 'package:parking_management/models/licenseplate_model.dart';

class LicenseService {
  
  Future<http.Response> createLicense(
      LicensePlate licensePlate, String token) async {
    var url = "https://cristhiankelm.me/api/carIdentities/create";
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
}
