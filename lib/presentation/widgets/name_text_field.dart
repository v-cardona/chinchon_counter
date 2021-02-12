import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/presentation/bloc/player/player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_14.w, vertical: Sizes.dimen_8.h),
      child: TextField(
        onChanged: (value) {
          BlocProvider.of<PlayerBloc>(context).add(ChangePlayerNameEvent(name: value));
        },
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          fillColor: Colors.white,
          labelText: TranslationConstants.name,
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple, width: 2),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(10)),
        ),
        maxLines: 1,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
