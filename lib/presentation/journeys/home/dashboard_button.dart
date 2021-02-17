import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class DashboardButton extends StatelessWidget {

  final String text;
  final List<Color> colorsGradient;
  final Function onPressed;

  const DashboardButton({Key key, @required this.text, @required this.colorsGradient, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: colorsGradient),
            borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_20.w))),
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_50.w,
        ),
        margin: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
        height: Sizes.dimen_20.h,
        width: Sizes.dimen_300,
        child: FlatButton(
          onPressed: onPressed,
          child: Text(
            text.translate(),
            style: Theme.of(context).textTheme.button,
          ),
        ));
  }
}
