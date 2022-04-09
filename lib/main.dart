import 'package:flutter/material.dart';
import 'package:parking_management/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';

void main() {
  runApp(
    const Myapp(),
  );
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Estacionamiento',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login': (_) => const LoginPage(),
          'home': (_) => HomePage(),
          'street': (_) => const StreetPage()
        },
        theme: ThemeData.light());
  }
}
