import 'package:chinchon_counter/data/tables/player_table.dart';
import 'package:chinchon_counter/presentation/chinchon_counter_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:pedantic/pedantic.dart';
import 'di/get_it.dart' as getIt;
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  // initialize dependency injection
  unawaited(getIt.init());
  // initialize noSql bda
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(PlayerTableAdapter());
  // run app
  runApp(ChinchonCounterApp());
}
