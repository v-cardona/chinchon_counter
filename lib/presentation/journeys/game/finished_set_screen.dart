import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/presentation/bloc/game/game_bloc.dart';
import 'package:chinchon_counter/presentation/themes/app_color.dart';
import 'package:chinchon_counter/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'datatable_set_widget.dart';

class FinishedSetScreen extends StatelessWidget {
  const FinishedSetScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameState state = BlocProvider.of<GameBloc>(context).state;
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationConstants.finishedSet.translate()),
        leading: Icon(Icons.close),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(Sizes.dimen_15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TranslationConstants.lostLifes.translate(),
                  style: TextStyle(
                      color: Colors.white, fontSize: Sizes.dimen_18.sp),
                ),
                for (var i = 0; i < state.lostLifesPlayers.length; i++)
                  ListTile(
                      leading: Image.asset("assets/images/favorite-broken.png"),
                      title: Text(
                        '${state.lostLifesPlayers[i].name}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                RichText(
                    text: TextSpan(
                        text: TranslationConstants.setResumen.translate(),
                        style: TextStyle(
                            color: Colors.white, fontSize: Sizes.dimen_18.sp),
                        children: [
                      TextSpan(
                        text: '${state.actualSet + 1}',
                        style: TextStyle(
                            color: Colors.white, fontSize: Sizes.dimen_18.sp),
                      )
                    ])),
                Expanded(
                  child: DatatableSetWidget(
                    state: state,
                    headingRowColor: AppColor.vulcan,
                    showGameFinishedResume: false,
                  ),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Button(
                  text: TranslationConstants.continueBtn,
                  onPressed: () {
                    BlocProvider.of<GameBloc>(context).add(NextSet());
                    Navigator.of(context).pop();
                  }))
        ],
      ),
    );
  }
}
