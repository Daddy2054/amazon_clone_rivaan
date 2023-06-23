import 'package:amazon_clone_rivaan/constants/error_handling.dart';
import 'package:amazon_clone_rivaan/constants/global_variables.dart';
import 'package:amazon_clone_rivaan/constants/utils.dart';
import 'package:amazon_clone_rivaan/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      http.Response res1 = 
      await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
   //  if (!context.mounted) return;
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
}
