import 'dart:convert';

import 'package:amazon_clone_rivaan/constants/error_handling.dart';
import 'package:amazon_clone_rivaan/constants/global_variables.dart';
import 'package:amazon_clone_rivaan/constants/utils.dart';
import 'package:amazon_clone_rivaan/features/home/screens/home_screen.dart';
import 'package:amazon_clone_rivaan/models/user.dart';
import 'package:amazon_clone_rivaan/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );
      //   debugPrint(user.toJson().toString());
      http.Response res1 = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
        if (!context.mounted) return;
      httpErrorHandle(
        response: res1,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created!',
          );
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  //sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res1 = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // print(res1.body);
      if (!context.mounted) return;
      httpErrorHandle(
        response: res1,
        context: context,
        onSuccess: () async {
          // ignore: invalid_use_of_visible_for_testing_member
          SharedPreferences.setMockInitialValues({});
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res1.body);
          await prefs.setString('x-auth-token', jsonDecode(res1.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  //get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        userProvider.setUser(userRes.body);
        //get user data
      }
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }
}
