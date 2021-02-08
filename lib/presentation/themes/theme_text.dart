import 'package:flutter/material.dart';
class ThemeText {
  const ThemeText._();
  
}

extension ThemeTextExtension on TextTheme {
      
  TextStyle get greyCaption => caption.copyWith(
    color: Colors.grey
  );
}