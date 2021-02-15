import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/di/get_it.dart';
import 'package:chinchon_counter/presentation/bloc/create_player/create_player_bloc.dart';
import 'package:chinchon_counter/presentation/widgets/button.dart';
import 'package:chinchon_counter/presentation/widgets/color_picker_widget.dart';
import 'package:chinchon_counter/presentation/widgets/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePlayerForm extends StatefulWidget {
  const CreatePlayerForm({Key key}) : super(key: key);

  @override
  _CreatePlayerFormState createState() => _CreatePlayerFormState();
}

class _CreatePlayerFormState extends State<CreatePlayerForm> {
  CreatePlayerBloc _createPlayerBloc;

  @override
  void initState() {
    super.initState();
    _createPlayerBloc = getItInstance<CreatePlayerBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _createPlayerBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePlayerBloc, CreatePlayerState>(
      builder: (context, state) {
        return Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NameTextField(),
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
                  ColorPickerWidget(color: state.color)
                ],
              ),
            ),
            Expanded(child: Container()),
            Button(
              onPressed: () =>
                  BlocProvider.of<CreatePlayerBloc>(context).add(AddPlayerEvent()),
              text: TranslationConstants.newPlayer,
            )
          ],
        ));
      },
    );
  }
}
