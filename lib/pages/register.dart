import 'package:chat_app/widgets/custom_show_dialog.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/custom_raised_buttom.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Logo(),
                _Form(),
                Labels(
                  route: 'login',
                  title: '¿Ya tienes una cuenta?',
                  subTitle: 'Inicia Sesion',
                ),
                Text(
                  'Terminos y condiciones de uso',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w200),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  _Form({Key key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          CustomInput(
            controllerTextField: nameCtrl,
            hintText: 'Name',
            keyboardType: TextInputType.text,
            icon: Icons.person_outline,
          ),
          CustomInput(
            controllerTextField: emailCtrl,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            icon: Icons.email_outlined,
          ),
          CustomInput(
            controllerTextField: passwordCtrl,
            hintText: 'Password',
            icon: Icons.lock_outline_sharp,
            obscureText: true,
          ),
          CustomRaisedButton(
            color: Colors.blue,
            text: 'Crea una cuenta',
            onPressed: authService.autenticando
                ? null
                : () async {
                    final loginCorrect = await authService.register(
                        nameCtrl.text, emailCtrl.text, passwordCtrl.text);

                    nameCtrl.clear();
                    emailCtrl.clear();
                    passwordCtrl.clear();

                    if (loginCorrect == true) {
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      CustomShowDialog(
                          context, 'Ingrese un correo valido', loginCorrect);
                    }
                  },
          ),
        ],
      ),
    );
  }
}
