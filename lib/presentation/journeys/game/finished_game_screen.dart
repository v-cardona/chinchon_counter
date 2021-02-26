import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/presentation/bloc/game/game_bloc.dart';
import 'package:chinchon_counter/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'datatable_set_widget.dart';

class FinishedGameScreen extends StatelessWidget {
  const FinishedGameScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameState state = BlocProvider.of<GameBloc>(context).state;
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationConstants.finishedGame.translate()),
        leading: Icon(Icons.close),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes.dimen_15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Image.asset(
              "assets/images/podium.png",
              height: Sizes.dimen_70.h,
              fit: BoxFit.fill,
            )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
              child: ListTile(
                  leading: Image.asset(
                    "assets/images/trophy.png",
                    color: AppColor.celery,
                  ),
                  title: Text(
                    '${state.winner.name}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Sizes.dimen_8.h),
              child: ListTile(
                  leading: Image.asset(
                    "assets/images/skull.png",
                    color: AppColor.chestnut,
                  ),
                  title: Text(
                    '${state.loser.name}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
            ),
            Text(
              TranslationConstants.gameResumen.translate(),
              style:
                  TextStyle(color: Colors.white, fontSize: Sizes.dimen_18.sp),
            ),
            Expanded(
              child: DatatableSetWidget(
                state: state,
                headingRowColor: AppColor.vulcan,
                showGameFinishedResume: true,
                showLifes: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
