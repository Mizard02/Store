import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/HomePageAuth.dart';
import 'package:flutter_application_1/restManagers/HttpRequest.dart';
import 'package:flutter_application_1/supports/Constants.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_application_1/pages/HomePage.dart';
import 'package:http/http.dart' as http;

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    return Future.delayed(loginTime).then((_) {
      return Model.sharedInstance.logIn(data.name, data.password);
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return "success";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'STORE',
      //logo: AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _authUser,
      //onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacementNamed('/homePageAuth');
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}