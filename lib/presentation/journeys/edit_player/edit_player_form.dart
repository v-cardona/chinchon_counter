import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/bloc/edit_player/edit_player_bloc.dart';
import 'package:chinchon_counter/presentation/widgets/button.dart';
import 'package:chinchon_counter/presentation/widgets/color_picker_widget.dart';
import 'package:chinchon_counter/presentation/widgets/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPlayerForm extends StatelessWidget {
  final PlayerEntity playerEntity;

  const EditPlayerForm({Key key, @required this.playerEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EditPlayerBloc>(context)
        .add(ChangePlayerNameEvent(name: playerEntity.name));
    BlocProvider.of<EditPlayerBloc>(context)
        .add(ChangePlayerColorEvent(color: playerEntity.color));

    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NameTextField(
          initialText: playerEntity.name,
          onPressed: (value) => BlocProvider.of<EditPlayerBloc>(context)
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
              BlocBuilder<EditPlayerBloc, EditPlayerState>(
                builder: (context, state) {
                  return ColorPickerWidget(
                    color: state.color,
                    onColorChange: (newColor) =>
                        BlocProvider.of<EditPlayerBloc>(context)
                            .add(ChangePlayerColorEvent(color: newColor.value)),
                  );
                },
              )
            ],
          ),
        ),
        Expanded(child: Container()),
        Button(
          onPressed: () => BlocProvider.of<EditPlayerBloc>(context)
              .add(EditPlayerEvent(playerId: playerEntity.id)),
          text: TranslationConstants.save,
        )
      ],
    ));
  }
}
