import 'package:movies_app/core/helpers/app_regex.dart';
import 'package:movies_app/core/helpers/password_validation/password_validation.dart';
import 'package:movies_app/core/localization/generated/l10n.dart';

class PasswordSpecialCharacterValidation implements PasswordValidation {
  @override
  bool validatePassword(String value) {
    if (AppRegex.hasSpecialCharacter(value)) {
      return true;
    }
    return false;
  }

  @override
  String get validateText =>
      AppLocalizations.current.passwordMustContainAtLeastOneSpecialCharacter;
}
