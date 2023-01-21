import 'package:validators/validators.dart';
import '../constant/app_strings.dart';
import '../model/form_validation.dart';

class FormValidator {
  FormValidator._() {
    throw AssertionError('private constructor');
  }

  static FormValidation validateNullableEmail(String? value) {
    if (value == null || value.isEmpty) {
      return FormValidation.ok();
    }
    return _validateEmail(value);
  }

  static FormValidation validateRequireEmail(String? value) {
    if (value == null || value.isEmpty) {
      return FormValidation.empty();
    }
    return _validateEmail(value);
  }

  static FormValidation _validateEmail(String value) {
    if (_hasFullWidthString(value)) {
      return FormValidation(
        isValid: false,
        message: Strings.fullWidthCharExist,
      );
    }

    if (isEmail(value)) {
      return FormValidation.ok();
    }
    return FormValidation(
      isValid: false,
      message: Strings.notEmailError,
    );
  }

  static FormValidation validateRequirePoint(String? value) {
    if (value == null || value.isEmpty) {
      return FormValidation.empty();
    }
    return FormValidation.ngNumeric();
  }

  static FormValidation validateEditBasicInfo({
    String? value,
    required int maxLength,
  }) {
    if (value == null || value.isEmpty) {
      return FormValidation.ngMessage();
    }
    if (!isLength(value, 1, maxLength)) {
      return FormValidation.ngLength(max: maxLength);
    }
    return FormValidation.ok();
  }

  static bool _hasFullWidthString(String text) => RegExp(r'[^\x01-\x7E]+').hasMatch(text);

  static FormValidation validateInquiryBody(String? value) {
    if (value == null || value.isEmpty) {
      return FormValidation.empty();
    }

    const maxLength = 1000;
    if (!isLength(value, 0, maxLength)) {
      return FormValidation.ngLength(min: null, max: maxLength);
    }

    return FormValidation.ok();
  }

  static FormValidation validateReportDetail(String? value) {
    if (value == null || value.isEmpty) {
      return FormValidation.empty();
    }

    const maxLength = 1000;
    if (!isLength(value, 0, maxLength)) {
      return FormValidation.ngLength(min: null, max: maxLength);
    }

    return FormValidation.ok();
  }
}
