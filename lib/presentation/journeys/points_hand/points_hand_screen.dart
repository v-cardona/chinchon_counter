import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/di/get_it.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/bloc/game/game_bloc.dart';
import 'package:chinchon_counter/presentation/bloc/points_hand/points_hand_bloc.dart';
import 'package:chinchon_counter/presentation/journeys/points_hand/points_player_list_item_widget.dart';
import 'package:chinchon_counter/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointsHandScreen extends StatefulWidget {
  final List<PlayerEntity> players;

  PointsHandScreen({Key key, @required this.players}) : super(key: key);

  @override
  _PointsHandScreenState createState() => _PointsHandScreenState();
}

class _PointsHandScreenState extends State<PointsHandScreen> {
  PointsHandBloc _pointsHandBloc;

  @override
  void initState() {
    super.initState();
    _pointsHandBloc = getItInstance<PointsHandBloc>();
    _pointsHandBloc.add(InitPointsHandEvent(players: widget.players));
  }

  @override
  void dispose() {
    super.dispose();
    _pointsHandBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationConstants.addPoints.translate()),
      ),
      body: BlocProvider(
          create: (context) => _pointsHandBloc,
          child: BlocConsumer<PointsHandBloc, PointsHandState>(
            builder: (context, state) {
              if (state.status == PointsHandStatus.changed) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.points.length,
                        itemBuilder: (context, index) => PointsPlayerListItem(
                          player: widget.players[index],
                          index: index,
                        ),
                      ),
                    ),
                    Button(
                        text: TranslationConstants.save,
                        onPressed: () =>
                            _pointsHandBloc.add(AddPointsHandEvent()))
                  ],
                );
              }
              return CircularProgressIndicator();
            },
            listener: (context, state) {
              if (state.status == PointsHandStatus.submitted) {
                BlocProvider.of<GameBloc>(context)
                    .add(AddPointsHand(points: state.points));
                Navigator.of(context).pop();
              }
            },
          )),
    );
  }
}
