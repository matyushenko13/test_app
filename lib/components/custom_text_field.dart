import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final TextEditingController controller;
  final Function onSubmitted;
  final Function onChanged;
  final double verticalPadding;
  final double horizontalPadding;

  CustomTextField({
    Key key,
    this.verticalPadding = 8,
    this.horizontalPadding = 16,
    this.hintText = "",
    this.keyboardType = TextInputType.number,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    @required this.controller,
    this.onSubmitted,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        focusNode: focusNode ?? FocusNode(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.blue
              )),
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding
          )),
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
    );
  }
}