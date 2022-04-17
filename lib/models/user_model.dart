class User {
  int? id;
  String? email;
  String? name;
  String? password;
  String? token;

  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['user']['id'];
    email = json['user']['email'];
    name = json['user']['name'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;
    data['password_confirmation'] = password;
    return data;
  }
}
