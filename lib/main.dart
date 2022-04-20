import 'package:flutter/material.dart';
import 'package:parking_management/providers/auth_provider.dart';
import 'package:parking_management/providers/street_provider.dart';
import 'package:parking_management/screens/license_screen.dart';
import 'package:parking_management/providers/license_plate_provider.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(create: (context) => StreetProvider()),
      Provider(create: (context) => AuthProvider()),
      Provider(create: (context) => LicenseProvider()),
    ],
    child: const Myapp(),
  ));
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
          'street': (_) => const StreetPage(),
          'license': (_) => const LicensePlateScreen()
        },
        theme: ThemeData.light());
  }
}
