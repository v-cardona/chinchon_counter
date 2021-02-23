import 'package:flutter/material.dart';

class PointsNumberField extends StatelessWidget {
  final String initialText;
  final Function onPressed;
  final String labelText;

  const PointsNumberField(
      {Key key, this.initialText = '', this.onPressed, this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialText,
      onChanged: onPressed,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        fillColor: Colors.white,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(10)),
      ),
      maxLines: 1,
      style: TextStyle(color: Colors.white),
    );
  }
}
