import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/presentation/bloc/create_player/create_player_bloc.dart';
import 'package:chinchon_counter/presentation/widgets/user_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerWidget extends StatelessWidget {

  final int color;

  const ColorPickerWidget({Key key, @required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            child: AlertDialog(
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: Color(color),
                  onColorChanged: (newColor) {
                    BlocProvider.of<CreatePlayerBloc>(context).add(ChangePlayerColorEvent(color: newColor.value));
                  },
                  showLabel: true,
                  pickerAreaHeightPercent: 0.8,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(TranslationConstants.done.translate(context)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
      },
      child: UserColorWidget(
        color: color,
      ),
    );
  }
}
