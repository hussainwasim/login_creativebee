import 'dart:convert';
import 'package:fin/view/admin_dashbord/admin_dashboard.dart';

import 'package:fin/view/login/login.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../utils/storage_helpers/storage_helpers.dart';
import '../utils/storage_helpers/storage_helpers_string.dart';

class LoginProviderModel with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
// mobile_no password

  Future<void> login(BuildContext context) async {
    await _storage.write(
        key: 'User_email', value: emailController.text.toString());
  }
}
