import 'dart:convert';

import 'package:http/http.dart';
import 'package:parking_management/models/errors_auth.dart';
import 'package:parking_management/models/user_model.dart';
import 'package:parking_management/services/auth_service.dart';

class AuthProvider {
  AuthService service = AuthService();
  User userCurrent = User();
  late ErrorsAuth _errorsAuth;
  var status;

  Future<int> userSignIn(User user) async {
    Response response = await service.loginData(user);
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      userCurrent = User.fromJson(json.decode(response.body));
    }

    if (response.statusCode == 200) {
      return response.statusCode;
    } else if (response.statusCode == 422) {
      return response.statusCode;
    }
    return 0;
  }

  Future<List> registerUser(User user) async {
    Response response = await service.registerData(user);
    status = response.body.contains('error');

    if (status) {
      _errorsAuth = ErrorsAuth.fromJson(await jsonDecode(response.body));
    } else {
      userCurrent = User.fromJson(await jsonDecode(response.body));
      print('data : ${userCurrent.token}');
    }

    if (response.statusCode == 200) {
      return ["200"];
    } else if (response.statusCode == 422) {
      return _errorsAuth.errors;
    }
    return [];
  }

  Future<bool> logout() async {
    Response response = await service.logout(userCurrent.token!);
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      if (response.statusCode != 200) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }
}
