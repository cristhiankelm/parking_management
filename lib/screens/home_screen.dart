import 'package:flutter/material.dart';
import 'package:parking_management/widgets/appbar.dart';
import 'package:parking_management/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: const AppDrawer(),
        appBar: Appbar(
          pageContext: context,
          scaffoldKey: _scaffoldKey,
          background: Colors.white,
          drawerColor: const Color.fromARGB(255, 0, 80, 200),
        ),
        body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Welcome to App!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 80, 200),
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Abra el menu y elija una opcion",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 80, 200),
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
