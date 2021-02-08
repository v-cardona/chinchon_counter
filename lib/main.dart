import 'package:chinchon_counter/presentation/chinchon_counter_app.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'di/get_it.dart' as getIt;

import 'common/screenutil/screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize dependency injection
  unawaited(getIt.init());
  // Initialize ScreenUtil so that it can use it while defining
  ScreenUtil.init();
  runApp(ChinchonCounterApp());
}