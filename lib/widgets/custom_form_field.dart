import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String value;
  final String hintText;
  final Function onSaved;
  final Function validator;
  final int maxLines;
  final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.black, width: 2));
  final OutlineInputBorder errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.red, width: 2));

  CustomFormField({
    this.value,
    this.hintText,
    this.onSaved,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        initialValue: value,
        onSaved: onSaved,
        validator: validator,
        maxLines: maxLines,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(color: Colors.black),
          focusedErrorBorder: errorBorder,
          errorBorder: errorBorder,
          focusedBorder: border,
          enabledBorder: border,
        ),
      ),
    );
  }
}
