import 'package:chinchon_counter/common/constants/languages.dart';
import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/screenutil/screenutil.dart';
import 'package:chinchon_counter/presentation/journeys/home/home_screen.dart';
import 'package:chinchon_counter/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

class ChinchonCounterApp extends StatelessWidget {
  const ChinchonCounterApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil so that it can use it while defining
    ScreenUtil.init();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: TranslationConstants.appTitle,
      theme: ThemeData(
          primaryColor: AppColor.mulledWine,
          accentColor: AppColor.screaminGreen,
          scaffoldBackgroundColor: AppColor.vulcan,
          unselectedWidgetColor: AppColor.violet,
          toggleableActiveColor: AppColor.violet,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          canvasColor: AppColor.mulledWine,
          cursorColor: Colors.deepPurple),
      supportedLocales: Languages.languages.map((e) => Locale(e.code)).toList(),
      locale: Locale('es'),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      initialRoute: '/',
      routes: {'/': (context) => HomeScreen()},
    );
  }
}
