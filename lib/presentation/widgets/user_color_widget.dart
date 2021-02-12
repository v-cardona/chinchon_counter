import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:flutter/material.dart';

class UserColorWidget extends StatelessWidget {
  final int color;
  const UserColorWidget({Key key, @required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Sizes.dimen_10.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(color),
      ),
      width: Sizes.dimen_38.w,
      height: Sizes.dimen_38.h
    );
  }
}
