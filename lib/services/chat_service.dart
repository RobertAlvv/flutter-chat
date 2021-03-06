import 'package:chat_app/globals/enviroment.dart';
import 'package:chat_app/models/mensaje_response.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/models/usuario.dart';

class ChatService with ChangeNotifier {
  Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final resp = await http.get(
      '${Enviroment.urlApi}/mensajes/$usuarioID',
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      },
    );

    MensajesResponse mensajeResp = mensajesResponseFromJson(resp.body);

    return mensajeResp.mensajes;
  }
}
