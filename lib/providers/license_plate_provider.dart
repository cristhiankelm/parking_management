import 'dart:convert';

import 'package:http/http.dart';
import 'package:parking_management/models/licenseplate_model.dart';
import 'package:parking_management/models/street_model.dart';
import 'package:parking_management/services/license_plate_service.dart';

class LicenseProvider {
  List<LicensePlate> licenses = [];
  List<LicensePlate> listLicenses = [];

  Street? street;

  LicenseService service = LicenseService();

  var status;

  filterCities() {
    for (var i = 0; i < licenses.length; i++) {
      if (licenses[i].street!.id == street!.id) {
        listLicenses.add(licenses[i]);
      }
    }
  }

  Future completeLicenses(String currentToken) async {
    Response response = await service.getAllLicenses(currentToken);
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      if (response.statusCode == 200) {
        Map<String, dynamic> map = Map.castFrom(data);
        for (var i = 0; i < map['data'].length; i++) {
          licenses.add(LicensePlate.fromJson(map['data'][i]));
        }
      }
    }
  }
}
