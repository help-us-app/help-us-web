
import 'package:flutter/material.dart';
import 'package:help_us_web/utils/db.dart';

class DashboardBloc {
  TextEditingController email = TextEditingController();
  DB db = DB();

  dispose() {
    email.dispose();
  }

  void saveUser(BuildContext context) {
    var emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(email.text)) {
      return;
    }
    db.setUser(email.text);
    Navigator.pop(context);
  }
}

class DashboardState {

}