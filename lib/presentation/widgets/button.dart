import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/common/screenutil/screenutil.dart';
import 'package:chinchon_counter/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  
  final String text;
  final Function onPressed;

  const Button({
    Key key,
    @required this.text,
    @required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.royalBlue,
            AppColor.violet
          ]
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.dimen_20.w)
        )
      ),
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_6.h, horizontal: Sizes.dimen_6.w),
      height: Sizes.dimen_24.h,
      width: ScreenUtil.screenWidth,
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          text.translate(context),
          style: Theme.of(context).textTheme.button.copyWith(fontSize: Sizes.dimen_18.sp),
        ),
      )
    );
  }
}
