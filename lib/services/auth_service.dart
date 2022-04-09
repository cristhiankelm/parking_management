import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parking_management/models/errors_auth.dart';
import 'package:parking_management/models/user_model.dart';

class AuthService {
  late User _newUser;
  late ErrorsAuth _errorsAuth;

  get user => _newUser;

  Future<List> registerUser(User user) async {
    var url = "https://cristhiankelm.me/api/register";
    var data = {
      "name": user.name,
      "email": user.email,
      "password": user.password,
      "password_confirmation": user.password,
    };
    var headers = {"Accept": "application/json"};
    var res = await http.post(Uri.parse(url), body: data, headers: headers);

    if (res.statusCode == 200) {
      _newUser = User.fromJson(await jsonDecode(res.body));
      return ["200"];
    } else if (res.statusCode == 422) {
      _errorsAuth = ErrorsAuth.fromJson(await jsonDecode(res.body));
      return _errorsAuth.errors;
    }
    return [];
  }

  Future<int> userSignIn(User user) async {
    var url = "https://cristhiankelm.me/api/login";
    var data = {
      'email': user.email,
      'password': user.password,
    };

    var res = await http.post(Uri.parse(url), body: data);

    if (res.statusCode == 200) {
      return res.statusCode;
    } else if (res.statusCode == 422) {
      return res.statusCode;
    }
    return 0;
  }
}
