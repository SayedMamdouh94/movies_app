import 'package:movies_app/core/helpers/password_validation/password_length_validation.dart';
import 'package:movies_app/core/helpers/password_validation/password_lower_case_validation.dart';
import 'package:movies_app/core/helpers/password_validation/password_number_validation.dart';
import 'package:movies_app/core/helpers/password_validation/password_special_character_validation.dart';
import 'package:movies_app/core/helpers/password_validation/password_upper_case_validation.dart';
import 'package:movies_app/core/helpers/password_validation/password_validation.dart';

class PasswordValidationManager {
  PasswordValidationManager._();
  static List<PasswordValidation> validations = [
    PasswordLengthValidation(),
    PasswordUpperCaseValidation(),
    PasswordLowerCaseValidation(),
    PasswordNumberValidation(),
    PasswordSpecialCharacterValidation(),
  ];
}
