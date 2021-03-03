import 'package:chinchon_counter/common/constants/game_constants.dart';
import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/presentation/bloc/select_lifes_game/select_lifes_game_bloc.dart';
import 'package:chinchon_counter/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionsGameLifes extends StatelessWidget {
  const OptionsGameLifes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(Sizes.dimen_14.w, Sizes.dimen_8.h, 0, 0),
          child: Text(
            TranslationConstants.chooseLifes.translate(),
            style: TextStyle(color: Colors.white, fontSize: Sizes.dimen_16.sp),
          ),
        ),
        BlocBuilder<SelectLifesGameBloc, SelectLifesGameState>(
          builder: (context, state) {
            int lifes = 1;
            if (state is ChangedSelectLifesGameState) {
              lifes = state.lifes;
            }
            return Row(
              children: [
                Expanded(
                  child: Slider(
                    value: lifes.toDouble(),
                    onChanged: (value) =>
                        BlocProvider.of<SelectLifesGameBloc>(context)
                            .add(ToggleSelecLifeEvent(lifes: value.toInt())),
                    min: GameConstants.min_lifes.toDouble(),
                    max: GameConstants.max_lifes.toDouble(),
                    divisions: 4,
                    activeColor: AppColor.violet,
                    inactiveColor: AppColor.mulledWine,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: Sizes.dimen_14.w),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: AppColor.violet,
                        size: Sizes.dimen_40,
                      ),
                      Text('$lifes',
                          style: TextStyle(
                            color: Colors.white,
                          ))
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
