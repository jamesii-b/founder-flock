import 'dart:convert';
import 'package:FounderFlock/main.dart';
import 'package:FounderFlock/provider/login_instance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginResult {
  final bool status;
  final String? errorMessage;

  LoginResult(this.status, {this.errorMessage});
}

class LoginViewModel extends ChangeNotifier {
  Future<LoginResult> login(
      BuildContext context, String email, String password) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$serverURL/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200)  {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        Provider.of<UserProvider>(context, listen: false)
            .updateuID(responseData['_id']);
        Provider.of<UserProvider>(context, listen: false)
            .updateEmail(responseData['email']);
        Provider.of<UserProvider>(context, listen: false)
            .updateLoginStatus(true);

        return LoginResult(true);
      } else if (response.statusCode == 403) {
        return LoginResult(false, errorMessage: 'Invalid email or password.');
      } else if (response.statusCode == 500) {
        return LoginResult(false,
            errorMessage: 'Internal server error. Please try again later.');
      } else {
        return LoginResult(false,
            errorMessage: 'An error occurred while logging in.');
      }
    } catch (e) {
      return LoginResult(false,
          errorMessage: 'An error occurred while logging in.');
    }
  }
}
