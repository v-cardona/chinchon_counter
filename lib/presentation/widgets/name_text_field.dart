import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {

  final String initialText;
  final Function onPressed;

  const NameTextField({Key key, this.initialText = '', this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_14.w, vertical: Sizes.dimen_8.h),
      child: TextFormField(
        initialValue: initialText,
        onChanged: onPressed,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          fillColor: Colors.white,
          labelText: TranslationConstants.name.translate(context),
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
      ),
    );
  }
}
