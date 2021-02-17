import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/presentation/bloc/create_player/create_player_bloc.dart';
import 'package:chinchon_counter/presentation/widgets/button.dart';
import 'package:chinchon_counter/presentation/widgets/color_picker_widget.dart';
import 'package:chinchon_counter/presentation/widgets/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePlayerForm extends StatelessWidget {
  const CreatePlayerForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NameTextField(
          onPressed: (value) => BlocProvider.of<CreatePlayerBloc>(context)
              .add(ChangePlayerNameEvent(name: value)),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Sizes.dimen_14.w, vertical: Sizes.dimen_8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TranslationConstants.chooseColor.translate(context),
                style: TextStyle(color: Colors.white),
              ),
              BlocBuilder<CreatePlayerBloc, CreatePlayerState>(
                builder: (context, state) {
                  return ColorPickerWidget(
                    color: state.color,
                    onColorChange: (newColor) =>
                        BlocProvider.of<CreatePlayerBloc>(context)
                            .add(ChangePlayerColorEvent(color: newColor.value)),
                  );
                },
              )
            ],
          ),
        ),
        Expanded(child: Container()),
        Button(
          onPressed: () =>
              BlocProvider.of<CreatePlayerBloc>(context).add(AddPlayerEvent()),
          text: TranslationConstants.createPlayer,
        )
      ],
    ));
  }
}
