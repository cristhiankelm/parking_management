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

  filterLicenses() {
    for (var i = 0; i < licenses.length; i++) {
      if (licenses[i].street_id == street!.id.toString()) {
        listLicenses.add(licenses[i]);
      }
    }
    listLicenses.reversed;
  }

  Future completeLicenses(String currentToken) async {
    Response response = await service.getAllLicenses(currentToken);
    status = response.body.contains('error');

    List data = json.decode(response.body);

    if (status) {
      //print('data : ${data["error"]}');
    } else {
      if (response.statusCode == 200) {
        for (var i = 0; i < data.length; i++) {
          licenses.add(LicensePlate.fromJson(data[i]));
        }
      }
    }
  }

  Future<bool> addLicense(LicensePlate license, String currentToken) async {
    Response response = await service.createLicense(license, currentToken);
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      return false;
    } else {
      if (response.statusCode == 201) {
        listLicenses.clear();
        LicensePlate plate = LicensePlate.fromJsonData(data);
        plate.street_id = street!.id.toString();
        licenses.add(plate);
        filterLicenses();
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> removeLicense(int id, String currentToken) async {
    Response response = await service.removeLicense(currentToken, id);
    status = response.body.contains('error');

    if (status) {
      return false;
    } else {
      if (response.statusCode == 200) {
        listLicenses.clear();
        // licenses.clear();
        // await completeLicenses(currentToken);
        licenses.removeWhere((element) => element.id == id);
        filterLicenses();
        return true;
      } else {
        return false;
      }
    }
  }
}
