import 'dart:convert';
import 'package:FounderFlock/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationResult {
  final bool success;
  final String? errorMessage;

  RegistrationResult(this.success, {this.errorMessage});
}

class RegistrationViewModel extends ChangeNotifier {
  Future<RegistrationResult> register(String email, String password) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$serverURL/api/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        return RegistrationResult(true);
      } else if (response.statusCode == 300) {
        return RegistrationResult(false,
            errorMessage: 'Syntax error in registration request.');
      } else if (response.statusCode == 500) {
        return RegistrationResult(false,
            errorMessage: 'Internal server error. Please try again later.');
      } else {
        return RegistrationResult(false,
            errorMessage: 'An error occurred during registration.');
      }
    } catch (e) {
      return RegistrationResult(false,
          errorMessage: 'An error occurred during registration.');
    }
  }
}
