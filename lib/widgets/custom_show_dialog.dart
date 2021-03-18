import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

CustomShowDialog(BuildContext context, String titulo, contenido) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(titulo),
          content: Text(contenido),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return CupertinoAlertDialog(
          title: Text(titulo),
          content: Text(contenido),
          actions: <Widget>[
            new CupertinoDialogAction(
              child: new Text("OK"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }
}
