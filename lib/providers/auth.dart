import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_expection.dart';

class Auth with ChangeNotifier {
  String _token = '';
  DateTime _expireDate = DateTime.now();
  String _userId = '';

  Future<void> authenicator(
      String email, String password, String urlSegment) async {
    // fill your google api key which will be available in firebase project seetings of your's
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=');
    try {
      var response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      print(response.body);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expireDate = _expireDate
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      // _expireDate = DateTime.now()
      //     .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      print(_token);
      print(_expireDate);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  bool get isAuthData {
    return token != null;
  }

  String? get token {
    if (_expireDate != null &&
        _expireDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> signup(String email, String password) async {
    return authenicator(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    return authenicator(email, password, ' signInWithPassword');
  }
}
