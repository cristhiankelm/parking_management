import 'package:flutter/material.dart';

PreferredSizeWidget Appbar({
  String title = '',
  bool showBack = false,
  required GlobalKey<ScaffoldState> scaffoldKey,
  required BuildContext pageContext,
  required Color background,
  Color? drawerColor,
}) {
  IconButton backIcon = IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: drawerColor,
        size: 30,
      ),
      onPressed: () {
        Navigator.pop(pageContext);
      });

  IconButton drawerIcon = IconButton(
      icon: Icon(
        Icons.menu_rounded,
        color: drawerColor,
        size: 40,
      ),
      onPressed: () {
        scaffoldKey.currentState?.openDrawer();
      });

  IconButton leadingButton = drawerIcon;

  if (showBack) {
    leadingButton = backIcon;
  }

  return AppBar(
    leading: leadingButton,
    centerTitle: false,
    elevation: 0,
    title: Text(title,
        style: TextStyle(
          color: drawerColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
    backgroundColor: background,
  );
}
