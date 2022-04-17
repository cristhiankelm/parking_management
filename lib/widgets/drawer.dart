import 'package:flutter/material.dart';
import 'package:parking_management/providers/auth_provider.dart';
import 'package:parking_management/providers/street_provider.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var streetProvider = Provider.of<StreetProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Drawer(
      backgroundColor: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 80, 200),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    width: 130,
                    // child: Image.asset(
                    //   'lib/assets/flutter1_devstravel_logo.png',
                    //   width: 120,
                    // )
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5, left: 15),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Version 1.0.0',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: GestureDetector(
                  onTap: () async {
                    if (streetProvider.states.isEmpty ||
                        streetProvider.cities.isEmpty ||
                        streetProvider.districts.isEmpty) {
                      await streetProvider
                          .completeStates(authProvider.userCurrent.token!);
                      await streetProvider
                          .completeCities(authProvider.userCurrent.token!);
                      await streetProvider
                          .completeDistricts(authProvider.userCurrent.token!);
                    }
                    Navigator.pushNamed(context, 'street');
                  },
                  child: Row(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.confirmation_num_outlined,
                          size: 25,
                          color: Color.fromARGB(255, 0, 80, 200),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          'Direcciones ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 80, 200),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: GestureDetector(
                onTap: () async {
                  if (streetProvider.streets.isEmpty) {
                    await streetProvider
                        .completeStreets(authProvider.userCurrent.token!);
                  }
                  Navigator.pushNamed(context, 'license');
                },
                child: Row(
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.call_to_action_outlined,
                        size: 25,
                        color: Color.fromARGB(255, 0, 80, 200),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Matriculas',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 80, 200),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
            Container(
              width: double.infinity,
              height: 50,
              child: GestureDetector(
                  onTap: () async {
                    if (await authProvider.logout()) {
                      Navigator.pushReplacementNamed(context, 'login');
                    }
                  },
                  child: Row(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.logout_outlined,
                          size: 25,
                          color: Color.fromARGB(255, 0, 80, 200),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          'Salir ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 80, 200),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
