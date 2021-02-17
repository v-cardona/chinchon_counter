import 'package:chinchon_counter/presentation/app_localizations.dart';

extension StringExtension on String {
  String translate() {
    return AppLocalizations.instance.translate(this);
  }
}
