import 'package:chat_app/globals/enviroment.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/models/usuarios_response.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/services/auth_service.dart';

class UsuarioService {
  Future<List<Usuario>> getUsuario() async {
    final resp = await http.get('${Enviroment.urlApi}/usuarios', headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken(),
    });

    if (resp.statusCode == 200) {
      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    }else{
      return [];
    }
  }
}
