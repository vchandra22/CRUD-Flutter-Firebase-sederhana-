import 'package:flutter/material.dart';
import 'package:aplikasi_uas/views/login_page.dart';
import 'package:aplikasi_uas/views/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initialy, show the login page
  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        showRegisterPage: toggleScreen,
      );
    } else {
      return RegisterPage(
        showLoginPage: toggleScreen,
      );
    }
  }
}
