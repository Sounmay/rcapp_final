import 'package:flutter/material.dart';
import 'package:rcapp/models/user.dart';
import 'package:rcapp/pages/CategoryMenuList/All_Menu.dart';
import 'package:rcapp/pages/Authenticate.dart';
import 'package:rcapp/pages/NavigationBar.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return NavigationBar();
    }
  }
}
