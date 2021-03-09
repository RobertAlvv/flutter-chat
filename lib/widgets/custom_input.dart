import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controllerTextField;
  final TextInputType keyboardType;
  final IconData icon;
  final bool obscureText;

  const CustomInput(
      {Key key,
      @required this.hintText,
      @required this.controllerTextField,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 5),
              blurRadius: 5),
        ],
      ),
      child: TextField(
        autocorrect: false,
        keyboardType: keyboardType,
        controller: controllerTextField,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon),
          focusedBorder: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
