import 'package:flutter/material.dart';
import 'package:shared_preference_lesson/home_page.dart';
import 'package:shared_preference_lesson/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences preference;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preference = await SharedPreferences.getInstance();
  bool login = preference.getBool("login") ?? false;
  runApp(MaterialApp(
    home: login == true ? HomePage() : LoginPage(preferences: preference),
  ));
}
