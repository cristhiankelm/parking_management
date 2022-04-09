class ErrorsAuth {
  late String message;
  late List<String> errors = [];

  ErrorsAuth.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors.add(json['errors']['email'].toString());
    errors.add(json['errors']['password'].toString());
  }
}
