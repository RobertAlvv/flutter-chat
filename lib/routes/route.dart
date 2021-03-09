import 'package:flutter/material.dart';

import 'package:chat_app/pages/chat.dart';
import 'package:chat_app/pages/loading.dart';
import 'package:chat_app/pages/login.dart';
import 'package:chat_app/pages/register.dart';
import 'package:chat_app/pages/usuarios.dart';

final Map<String, Widget Function(BuildContext)> appRoute = {
  'usuarios'  : ( _ ) => UsuariosPage(),
  'chat'      : ( _ ) => ChatPage(),
  'login'     : ( _ ) => LoginPage(),
  'register'  : ( _ ) => RegisterPage(),
  'loading'   : ( _ ) => LoadingPage(),

};