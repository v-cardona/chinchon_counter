import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/domain/entities/app_error.dart';

extension AppErrorExtension on AppError {

  String showError() {
    String error;
    switch (this.errorType) {
      case AppErrorType.dba:
        error = TranslationConstants.errorDb.translate();
        break;
      case AppErrorType.colorNotAvailable:
        error = TranslationConstants.errorcolorNotAvailable.translate();
        break;
      case AppErrorType.nameEmpty:
        error = TranslationConstants.errornameEmpty.translate();
        break;
      default:
        error = TranslationConstants.errorMsgGeneral.translate();
    }

    return error;
  }
}
