import 'package:movies_app/core/helpers/app_regex.dart';
import 'package:movies_app/core/helpers/password_validation/password_validation.dart';
import 'package:movies_app/core/localization/generated/l10n.dart';

class PasswordUpperCaseValidation implements PasswordValidation {
  @override
  bool validatePassword(String value) {
    if (AppRegex.hasUpperCase(value)) {
      return true;
    }
    return false;
  }

  @override
  String get validateText =>
      AppLocalizations.current.passwordMustContainAtLeastOneUppercaseLetter;
}
