import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/presentation/bloc/when_finish_game/when_finish_game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionsGameFinishRadio extends StatelessWidget {
  const OptionsGameFinishRadio({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(Sizes.dimen_14.w, Sizes.dimen_8.h, 0, 0),
          child: Text(
            TranslationConstants.chooseWhenFinishGame.translate(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        BlocBuilder<WhenFinishGameBloc, WhenFinishGameState>(
            builder: (context, state) {
          if (state is WhenFinishGameChanged) {
            return Column(
              children: [
                RadioListTile(
                  value: WhenFinishGameOptions.firstDead,
                  groupValue: state.whenFinish,
                  onChanged: (value) =>
                      BlocProvider.of<WhenFinishGameBloc>(context)
                          .add(ToogleWhenFinishEvent(whenFinish: value)),
                  title: Text(
                    TranslationConstants.finishGameFirstDead.translate(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                RadioListTile(
                  value: WhenFinishGameOptions.lastDead,
                  groupValue: state.whenFinish,
                  onChanged: (value) =>
                      BlocProvider.of<WhenFinishGameBloc>(context)
                          .add(ToogleWhenFinishEvent(whenFinish: value)),
                  title: Text(
                    TranslationConstants.finishGameLastDead.translate(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        }),
      ],
    );
  }
}
