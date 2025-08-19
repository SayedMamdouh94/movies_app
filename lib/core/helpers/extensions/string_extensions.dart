import 'package:movies_app/core/helpers/password_validation/password_validation_manager.dart';
import 'package:intl/intl.dart';

extension StringEx on String {
  String toStringAsFixed0() => num.parse(this).toStringAsFixed(0);
  int toInt() => int.parse(this);
  String noramlizeText() {
    return replaceAll('أ', 'ا').replaceAll('إ', 'ا').replaceAll('ة', 'ه');
  }

  String capitalizeFirst({characterLength = 2}) => trim()
      .split(' ')
      .map((l) => '${l[0].toUpperCase()} ')
      .take(characterLength)
      .join();

  String convertArabicToEnglishNumbers() {
    const arabicNumbers = '٠١٢٣٤٥٦٧٨٩';
    const englishNumbers = '0123456789';
    String input = this;
    for (int i = 0; i < arabicNumbers.length; i++) {
      input.replaceAll(arabicNumbers[i], englishNumbers[i]);
    }
    return input;
  }

  String get dateLabel {
    DateTime date = DateTime.parse(this);
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (date == today) {
      return 'اليوم';
    } else if (date == tomorrow) {
      return 'غداً';
    } else if (date == yesterday) {
      return 'أمس';
    } else {
      return DateFormat('dd MMM yyyy', 'ar-EG').format(date);
    }
  }

  bool get isNum {
    final numPattern = RegExp(r'^[0-9]+$');
    return numPattern.hasMatch(this);
  }

  bool get isValidWebsite {
    final urlPattern = RegExp(
      r'^(https?:\/\/)?(www\.)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}\/?$',
      caseSensitive: false,
    );
    return urlPattern.hasMatch(this);
  }
}

extension PathExtensions on String {
  String get png => 'assets/images/$this.png';
  String get jpg => 'assets/images/$this.jpg';
  String get lottie => 'assets/lottie/$this.json';
  String get gif => 'assets/gifs/$this.gif';
  String get svg => 'assets/svgs/$this.svg';
}

extension NotNullOrEmptyString on String? {
  bool get notNullOrEmpty => this != null && this!.isNotEmpty;
}

extension PasswordEx on String {
  String? validatePassword() {
    String? validateText;
    for (var validation in PasswordValidationManager.validations) {
      if (!validation.validatePassword(this)) {
        validateText = validation.validateText;
        break;
      }
    }
    return validateText;
  }
}
