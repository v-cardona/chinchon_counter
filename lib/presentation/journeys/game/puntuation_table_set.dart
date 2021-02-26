import 'package:chinchon_counter/presentation/bloc/game/game_bloc.dart';
import 'package:chinchon_counter/presentation/journeys/game/datatable_set_widget.dart';
import 'package:chinchon_counter/presentation/journeys/game/finished_set_screen.dart';
import 'package:chinchon_counter/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PuntuationTableSet extends StatelessWidget {
  const PuntuationTableSet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listener: (_, state) {
        if (state.status == GameStatus.finishedSet) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<GameBloc>(context),
                    child: FinishedSetScreen(),
                  )));
        }
      },
      builder: (_, state) {
        if (state.status == GameStatus.loaded) {
          return DatatableSetWidget(
            state: state,
            showLifes: true,
            headingRowColor: AppColor.mulledWine,
            editCell: true,
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
