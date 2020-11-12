import 'package:flutter/material.dart';
import 'package:test_app_checkbox/utils/app_strings.dart';

class ErrorDialog extends StatelessWidget{
  final String message;
  ErrorDialog({@required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.error),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text(AppStrings.ok),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ]);
  }
}