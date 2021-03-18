import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/globals/enviroment.dart';

class AuthService with ChangeNotifier {
  Usuario _usuario;
  bool _autenticando = false;

  final _storage = FlutterSecureStorage();

  Usuario get usuario => _usuario;

  bool get autenticando => _autenticando;

  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, password) async {
    autenticando = true;
    final resp = await http.post('${Enviroment.urlApi}/login',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}));

    print(resp.body);
    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this._usuario = loginResponse.usuario;
      _guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String name, email, password) async {
    autenticando = true;
    final resp = await http.post('${Enviroment.urlApi}/login/new',
        headers: {'Content-Type': 'application/json'},
        body:
            jsonEncode({'nombre': name, 'email': email, 'password': password}));

    print(resp.body);
    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this._usuario = loginResponse.usuario;
      _guardarToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggeIn() async {
    final _token = await this._storage.read(key: 'token');
    final resp = await http.get(
      '${Enviroment.urlApi}/login/renew',
      headers: {
        'Content-Type': 'application/json',
        'x-token' : _token,
      },
    );

    print(resp.body);
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this._usuario = loginResponse.usuario;
      _guardarToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
