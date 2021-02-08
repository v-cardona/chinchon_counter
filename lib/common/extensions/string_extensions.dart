import 'package:chinchon_counter/presentation/app_localizations.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  String translate(BuildContext context) {
    return AppLocalizations.of(context).translate(this);
  }
}
