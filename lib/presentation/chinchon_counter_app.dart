import 'package:chinchon_counter/common/constants/languages.dart';
import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

class ChinchonCounterApp extends StatelessWidget {
  const ChinchonCounterApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: TranslationConstants.appTitle,
        supportedLocales:
            Languages.languages.map((e) => Locale(e.code)).toList(),
        locale: Locale('es'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        home: Text('data'));
  }
}