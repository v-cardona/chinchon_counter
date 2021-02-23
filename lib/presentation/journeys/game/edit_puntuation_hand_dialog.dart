import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/di/get_it.dart';
import 'package:chinchon_counter/presentation/bloc/edit_points_hand/edit_points_hand_bloc.dart';
import 'package:chinchon_counter/presentation/widgets/user_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPuntuationHandEdit extends StatefulWidget {
  final String name;
  final int color;
  final int actualPoints;

  const EditPuntuationHandEdit({
    Key key,
    @required this.name,
    @required this.color,
    @required this.actualPoints,
  }) : super(key: key);

  @override
  _EditPuntuationHandEditState createState() => _EditPuntuationHandEditState();
}

class _EditPuntuationHandEditState extends State<EditPuntuationHandEdit> {
  EditPointsHandBloc _editPointsHandBloc;

  @override
  void initState() {
    super.initState();
    _editPointsHandBloc = getItInstance<EditPointsHandBloc>();
    _editPointsHandBloc
        .add(ChangeEditPointHandEvent(points: widget.actualPoints));
  }

  @override
  void dispose() {
    super.dispose();
    _editPointsHandBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditPointsHandBloc, EditPointsHandState>(
      cubit: _editPointsHandBloc,
      listener: (_, state) {
        if (state.status == EditPointsHandStatus.submitted) {
          Navigator.of(context).pop(state.points);
        }
      },
      child: AlertDialog(
        title: Text(TranslationConstants.editPoints.translate()),
        content: ListTile(
            leading: UserColorWidget(
              color: widget.color,
            ),
            title: TextFormField(
              initialValue: '${widget.actualPoints}',
              onChanged: (value) => _editPointsHandBloc
                  .add(ChangeEditPointHandEvent(points: int.parse(value))),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                fillColor: Colors.deepPurple,
                labelText: '${widget.name}',
                labelStyle: TextStyle(color: Colors.deepPurple),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              maxLines: 1,
              style: TextStyle(color: Colors.deepPurple),
            )),
        actions: [
          FlatButton(
            textColor: Color(0xFF6200EE),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(TranslationConstants.cancel.translate()),
          ),
          RaisedButton(
            color: Color(0xFF6200EE),
            onPressed: () => _editPointsHandBloc.add(SaveEditPointHandEvent()),
            child: Text(TranslationConstants.save.translate()),
          ),
        ],
      ),
    );
  }
}
