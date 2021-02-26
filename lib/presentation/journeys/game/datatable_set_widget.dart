import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/bloc/game/game_bloc.dart';
import 'package:chinchon_counter/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_puntuation_hand_dialog.dart';

class DatatableSetWidget extends StatelessWidget {
  final GameState state;
  final bool showLifes;
  final Color headingRowColor;
  final bool editCell;
  const DatatableSetWidget(
      {Key key,
      @required this.state,
      @required this.headingRowColor,
      this.showLifes = false,
      this.editCell = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor:
              MaterialStateColor.resolveWith((states) => headingRowColor),
          columns: _createColumns(state),
          rows: [
            // lifes
            if (showLifes) _createLifesRow(state),
            // sum points of set
            _createTotalPoints(state),
            // hands
            for (int i = 0; i < state.pointsActualSet.length; i++)
              DataRow(
                cells: [
                  for (int j = 0; j < state.pointsActualSet[i].length; j++)
                    DataCell(
                        Center(
                          child: Text(
                            '${state.pointsActualSet[i][j]}',
                            style: TextStyle(
                              color: AppColor.violet,
                              fontSize: Sizes.dimen_20.sp,
                            ),
                          ),
                        ), onTap: () {
                      if (editCell) {
                        String name = state.players[j].name;
                        int color = state.players[j].color;
                        int actualPoints = state.pointsActualSet[i][j];
                        int indexHand = i;
                        int indexPlayer = j;
                        showDialog(
                            context: context,
                            child: EditPuntuationHandEdit(
                              actualPoints: actualPoints,
                              color: color,
                              name: name,
                            )).then((value) {
                          if (value != null) {
                            BlocProvider.of<GameBloc>(context).add(
                                EditPointsHand(
                                    points: value,
                                    indexHand: indexHand,
                                    indexPlayer: indexPlayer));
                          }
                        });
                      }
                    })
                ],
              )
          ],
          columnSpacing: Sizes.dimen_20.w,
        ),
      ),
    );
  }

  List<DataColumn> _createColumns(GameState state) {
    List<DataColumn> columns = [];
    for (int i = 0; i < state.players.length; i++) {
      PlayerEntity player = state.players[i];
      DataColumn column = DataColumn(
          label: Expanded(
            child: Text(
              player.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: Sizes.dimen_18.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          numeric: false);
      columns.add(column);
    }
    return columns;
  }

  DataRow _createLifesRow(GameState state) {
    List<DataCell> cellsLifes = [];
    for (int i = 0; i < state.lifes.length; i++) {
      int lifes = state.lifes[i];
      List<Icon> iconsLifes = [];
      for (int i = 0; i < lifes; i++) {
        Icon icon = Icon(
          Icons.favorite,
          color: AppColor.violet,
        );
        iconsLifes.add(icon);
      }
      DataCell cell = DataCell(
        Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: iconsLifes,
        )),
      );
      cellsLifes.add(cell);
    }

    return DataRow(cells: cellsLifes);
  }

  DataRow _createTotalPoints(GameState state) {
    List<DataCell> cellsPoints = [];
    for (int i = 0; i < state.pointsSets[state.actualSet].length; i++) {
      int setPoints = state.pointsSets[state.actualSet][i];
      DataCell cell = DataCell(
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurple),
              borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_5))),
          child: Center(
              child: Text(
            '$setPoints',
            style: TextStyle(
              color: Colors.white,
              fontSize: Sizes.dimen_20.sp,
            ),
          )),
        ),
      );
      cellsPoints.add(cell);
    }
    return DataRow(cells: cellsPoints);
  }
}
