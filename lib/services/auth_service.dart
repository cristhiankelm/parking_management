import 'package:http/http.dart' as http;
import 'package:parking_management/models/user_model.dart';

class AuthService {
  String serverUrl = "http://smi-cloud.net/api";

  Future<http.Response> loginData(User user) async {
    String myUrl = "$serverUrl/login";
    final response = await http.post(
      Uri.parse(myUrl),
      headers: {'Accept': 'application/json'},
      body: user.toJson(),
    );
    return response;
  }

  Future<http.Response> logout(String token) async {
    String myUrl = "$serverUrl/auth/logout";
    final response = await http.post(
      Uri.parse(myUrl),
      headers: {'Authorization': 'Bearer ' + token},
    );
    return response;
  }

  Future<http.Response> registerData(User user) async {
    String myUrl = "$serverUrl/register";
    final response = await http.post(
      Uri.parse(myUrl),
      headers: {'Accept': 'application/json'},
      body: user.toJson(),
    );
    return response;
  }
}
