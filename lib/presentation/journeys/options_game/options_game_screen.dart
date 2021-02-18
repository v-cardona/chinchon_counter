import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:flutter/material.dart';

class OptionsGameScreen extends StatelessWidget {
  final List<PlayerEntity> playersSelected;

  const OptionsGameScreen({Key key, @required this.playersSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Optiones'),
      ),
    );
  }
}
