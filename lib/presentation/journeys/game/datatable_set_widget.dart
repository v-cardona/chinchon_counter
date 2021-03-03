import 'package:chinchon_counter/common/constants/game_constants.dart';
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
  final bool showGameFinishedResume;
  final Color headingRowColor;
  final bool editCell;
  final bool showCroupier;

  const DatatableSetWidget({
    Key key,
    @required this.state,
    @required this.headingRowColor,
    @required this.showGameFinishedResume,
    this.showLifes = false,
    this.editCell = false,
    this.showCroupier = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: Sizes.dimen_40.h),
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor:
              MaterialStateColor.resolveWith((states) => headingRowColor),
          columns: _createColumns(state, context, showCroupier),
          rows: [
            // lifes
            if (showLifes) _createLifesRow(state),
            if (showGameFinishedResume)
              for (int i = 0; i < state.pointsSets.length; i++)
                DataRow(cells: [
                  for (int j = 0; j < state.pointsSets[i].length; j++)
                    if (i <= state.lifesLostAt[j])
                      DataCell(
                        Container(
                          margin: EdgeInsets.only(bottom: Sizes.dimen_3.h),
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.deepPurple),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Sizes.dimen_5))),
                          child: Center(
                              child: Text(
                            '${state.pointsSets[i][j]}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.dimen_20.sp,
                            ),
                          )),
                        ),
                      )
                    else
                      DataCell(Center(
                          child: Icon(
                        Icons.close,
                        color: Colors.red[300],
                      ))),
                ]),
            // sum points of set
            if (!showGameFinishedResume) _createTotalPoints(state),
            // hands
            if (!showGameFinishedResume)
              for (int i = 0; i < state.pointsActualSet.length; i++)
                DataRow(
                  cells: [
                    for (int j = 0; j < state.pointsActualSet[i].length; j++)
                      if (state.lifes[j] != GameConstants.dead_player)
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
                      else
                        DataCell(Center(
                            child: Icon(
                          Icons.close,
                          color: Colors.red[300],
                        ))),
                  ],
                )
          ],
          columnSpacing: Sizes.dimen_20.w,
        ),
      ),
    );
  }

  List<DataColumn> _createColumns(
      GameState state, BuildContext context, bool showCroupier) {
    List<DataColumn> columns = [];
    for (int i = 0; i < state.players.length; i++) {
      PlayerEntity player = state.players[i];
      DataColumn column = DataColumn(
          label: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  player.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.dimen_18.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (showCroupier && i == state.croupier)
                  Container(
                    color: Theme.of(context).accentColor,
                    height: Sizes.dimen_4,
                  )
              ],
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
      DataCell cell;

      if (lifes != GameConstants.dead_player) {
        List<Icon> iconsLifes = [];

        for (int i = 0; i < lifes; i++) {
          Icon icon = Icon(
            Icons.favorite,
            color: AppColor.violet,
          );
          iconsLifes.add(icon);
        }
        cell = DataCell(
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: iconsLifes,
          )),
        );
      } else {
        cell = DataCell(
          Center(
              child: Icon(
            Icons.close,
            color: Colors.red,
          )),
        );
      }
      cellsLifes.add(cell);
    }

    return DataRow(cells: cellsLifes);
  }

  DataRow _createTotalPoints(GameState state) {
    List<DataCell> cellsPoints = [];
    for (int i = 0; i < state.pointsSets[state.actualSet].length; i++) {
      int setPoints = state.pointsSets[state.actualSet][i];
      DataCell cell;

      if (state.lifes[i] != GameConstants.dead_player) {
        cell = DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
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
      } else {
        cell = DataCell(
          Center(
              child: Icon(
            Icons.close,
            color: Colors.red[300],
          )),
        );
      }
      cellsPoints.add(cell);
    }
    return DataRow(cells: cellsPoints);
  }
}
