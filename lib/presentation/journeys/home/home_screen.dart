import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/presentation/journeys/all_players/all_players_screen.dart';
import 'package:chinchon_counter/presentation/journeys/home/dashboard_button.dart';
import 'package:chinchon_counter/presentation/journeys/select_players_game/select_players_game_screen.dart';
import 'package:chinchon_counter/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationConstants.appTitle.translate()),
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
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SelectPlayersGameScreen(),))),
            DashboardButton(
                text: TranslationConstants.allPlayers,
                colorsGradient: [
                  AppColor.dodgerBlue,
                  AppColor.pictonBlue,
                  AppColor.fountainBlue
                ],
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllPlayersScreen(),
                    ))),
          ],
        ),
      ),
    );
  }
}
