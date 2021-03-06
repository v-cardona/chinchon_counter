import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/app_error_extension.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/presentation/bloc/order_players/order_players_bloc.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/presentation/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_player_list_item_widget.dart';

class OrderPlayersWidget extends StatelessWidget {
  const OrderPlayersWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderPlayersBloc, OrderPlayersState>(
      listener: (context, state) {
        if (state.status == OrderPlayerStatus.error) {
          Scaffold.of(context).hideCurrentSnackBar();
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(state.appError.showError()), Icon(Icons.info)],
            ),
            backgroundColor: Colors.deepPurple,
          ));
        }
      },
      child: BlocBuilder<OrderPlayersBloc, OrderPlayersState>(
        builder: (context, state) {
          if (state.status == OrderPlayerStatus.loaded ||
              state.status == OrderPlayerStatus.error) {
            return Expanded(
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Sizes.dimen_14.w,
                      bottom: Sizes.dimen_8.h,
                      top: Sizes.dimen_8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        TranslationConstants.orderPlayers.translate(),
                        style: TextStyle(
                            color: Colors.white, fontSize: Sizes.dimen_16.sp),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                        onPressed: () => showDialog(
                            context: context,
                            child: AlertDialog(
                              actions: [
                                FlatButton(
                                  textColor: AppColor.electricViolet,
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(
                                      TranslationConstants.close.translate()),
                                ),
                              ],
                              content: Text(
                                TranslationConstants.infoOrderPlayersCroupier
                                    .translate(),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ReorderableListView(
                    children: [
                      for (final player in state.players)
                        OrderPlayerListItem(
                            key: ValueKey(player.id), player: player)
                    ],
                    onReorder: (oldIndex, newIndex) {
                      BlocProvider.of<OrderPlayersBloc>(context).add(
                          MovePlayerOrderEvent(
                              players: state.players,
                              oldIndex: oldIndex,
                              newIndex: newIndex));
                    },
                  ),
                ),
              ],
            ));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
