import 'package:flutter/material.dart';
import 'package:parking_management/widgets/appbar.dart';
import 'package:parking_management/widgets/drawer.dart';

class StreetPage extends StatefulWidget {
  const StreetPage({Key? key}) : super(key: key);

  @override
  State<StreetPage> createState() => _StreetPageState();
}

class _StreetPageState extends State<StreetPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      appBar: Appbar(
        title: 'Direcciones',
        pageContext: context,
        scaffoldKey: _scaffoldKey,
        showBack: true,
        background: const Color.fromARGB(255, 0, 80, 200),
        drawerColor: Colors.white,
      ),
    );
  }
}
