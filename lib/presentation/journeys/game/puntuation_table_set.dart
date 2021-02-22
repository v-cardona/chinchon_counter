import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/presentation/bloc/game/game_bloc.dart';
import 'package:chinchon_counter/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PuntuationTableSet extends StatelessWidget {
  const PuntuationTableSet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state.status == GameStatus.loaded) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => AppColor.mulledWine),
                columns: [
                  for (final player in state.players)
                    DataColumn(
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
                        numeric: false)
                ],
                rows: [
                  // lifes
                  DataRow(cells: [
                    for (int lifes in state.lifes)
                      DataCell(
                        Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < lifes; i++)
                              Icon(
                                Icons.favorite,
                                color: AppColor.violet,
                              )
                          ],
                        )),
                      )
                  ]),
                  // sum points of set
                  DataRow(cells: [
                    for (int setPoints in state.pointsSets[state.actualSet])
                      DataCell(
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.deepPurple),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Sizes.dimen_5))),
                          child: Center(
                              child: Text(
                            '$setPoints',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.dimen_20.sp,
                            ),
                          )),
                        ),
                      )
                  ]),
                  // hands
                  for (List points in state.pointsActualSet)
                    DataRow(cells: [
                      for (int point in points)
                        DataCell(
                          Center(
                              child: Text(
                            '$point',
                            style: TextStyle(
                              color: AppColor.violet,
                              fontSize: Sizes.dimen_20.sp,
                            ),
                          )),
                        )
                    ])
                ],
                columnSpacing: Sizes.dimen_20.w,
              ),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
