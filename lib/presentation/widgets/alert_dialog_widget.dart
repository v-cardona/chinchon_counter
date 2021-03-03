import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final Function onPressedYes;

  const AlertDialogWidget(
      {Key key,
      @required this.title,
      @required this.content,
      @required this.onPressedYes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FlatButton(
          textColor: AppColor.electricViolet,
          onPressed: () => Navigator.of(context).pop(),
          child: Text(TranslationConstants.no.translate()),
        ),
        FlatButton(
          textColor: AppColor.electricViolet,
          onPressed: onPressedYes,
          child: Text(TranslationConstants.yes.translate()),
        ),
      ],
    );
  }
}
