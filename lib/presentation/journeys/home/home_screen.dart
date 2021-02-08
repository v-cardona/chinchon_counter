import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/presentation/journeys/home/dashboard_button.dart';
import 'package:chinchon_counter/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationConstants.appTitle.translate(context)),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DashboardButton(
                text: TranslationConstants.newGame,
                colorsGradient: [
                  AppColor.sunglow,
                  AppColor.tulipTree,
                  AppColor.husk
                ],
                onPressed: () {}),
            DashboardButton(
                text: TranslationConstants.allPlayers,
                colorsGradient: [
                  AppColor.dodgerBlue,
                  AppColor.pictonBlue,
                  AppColor.fountainBlue
                ],
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
