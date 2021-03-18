import 'package:chat_app/pages/login.dart';
import 'package:chat_app/pages/usuarios.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loggerStated(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Esperando... '),
          );
        },
      ),
    );
  }

  Future loggerStated(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    final loggerState = await authService.isLoggeIn();

    if (loggerState) {
      return Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => UsuariosPage(),
          transitionDuration: Duration(milliseconds: 0),
        ),
      );
    } else {
      return Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginPage(),
          transitionDuration: Duration(milliseconds: 0),
        ),
      );
    }
  }
}
