import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  UserModel? _user;

  UserModel get user => _user!;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      saveUSer(user);
      _user = user;
      Navigator.pushReplacementNamed(context, '/home', arguments: user);
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> saveUSer(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString('user', user.toJson());
    return;
  }

  Future<void> deleteUSer() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    await _googleSignIn.disconnect();
    final instance = await SharedPreferences.getInstance();
    await instance.remove('user');
    return;
  }


  Future<void> currentUSer(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 2));
    if (instance.containsKey('user')) {
      final json = instance.get('user') as String;
      setUser(context, UserModel.fromJson(json));
      return;
    } else {
      setUser(context, null);
    }
  }
}
