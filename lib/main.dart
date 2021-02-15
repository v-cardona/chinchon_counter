import 'package:chinchon_counter/data/tables/player_table.dart';
import 'package:chinchon_counter/presentation/chinchon_counter_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pedantic/pedantic.dart';
import 'di/get_it.dart' as getIt;
import 'package:path_provider/path_provider.dart' as path_provider;

import 'common/screenutil/screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize dependency injection
  unawaited(getIt.init());
  // Initialize ScreenUtil so that it can use it while defining
  ScreenUtil.init();
  // initialize noSql bda
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(PlayerTableAdapter());
  // run app
  runApp(ChinchonCounterApp());
}