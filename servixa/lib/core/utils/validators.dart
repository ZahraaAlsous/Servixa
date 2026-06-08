import 'package:easy_localization/easy_localization.dart';
import 'package:servixa/features/search_filter/business_later/search_filter_controller.dart';
import 'package:get/get.dart' hide Trans;

class Validators {
  final SearchFilterController searchFilterController = Get.put(
    SearchFilterController(),
  );
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required".tr();
    }
    String email = value.trim();
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return "Enter a valid email address".tr();
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required".tr();
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter".tr();
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number".tr();
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain at least one special character".tr();
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters".tr();
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return "Confirm password is required".tr();
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters".tr();
    }
    if (value != password) {
      return "Passwords do not match".tr();
    }
    return null;
  }

  static String? validateChangePassword(String? value, String oldPassword) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required".tr();
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter".tr();
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number".tr();
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain at least one special character".tr();
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters".tr();
    }

    if (value.trim() == oldPassword.trim()) {
      return "The password matches the previous password.".tr();
    }

    return null;
  }

  static String? validateText(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return "$message" + " is required".tr();
    }
    return null;
  }

  static String? validateTextDinamckQuestion(
    String? value,
    String message,
    bool isRequired,
  ) {
    if (isRequired && (value == null || value.trim().isEmpty)) {
      return "$message" + " is required".tr();
    }

    if (value != null && value.isNotEmpty && value.trim().isEmpty) {
      return "Please enter a valid value".tr();
    }

    if (!isRequired && (value == null || value.isEmpty)) {
      return null;
    }

    // if (value != null && value.trim().isNotEmpty) {
    //   // if (value.trim().length < 2) {
    //   return "Please enter a valid value (at least 2 characters)".tr();
    //   // }
    // }

    return null;
  }

  static String? validatePhoneRegister(String? value, String? emailValue) {
    // // if (value == null || value.trim().isEmpty) {
    // //   return "This field is required";
    // // }
    // bool isPhone = true;
    // if (value != null  ) {
    //   String input = value.trim();
    //   //  isPhone = RegExp(r'^[0-9]{10,15}$').hasMatch(input);
    //    isPhone = RegExp(r'^[0-9]{9,15}$').hasMatch(input);
    // }
    // // bool isPhone = RegExp(r'^[0-9]{10,15}$').hasMatch(input);

    // // if (!isPhone && !isEmail) {
    // if (value != null && !isPhone) {
    //   return "Enter a valid phone number";
    // }

    // return null;

    String input = value?.trim() ?? "";
    String emailInput = emailValue?.trim() ?? "";

    if (input.isEmpty && emailInput.isEmpty) {
      return "Please enter either Email or Phone".tr();
    }

    if (input.isNotEmpty) {
      bool isPhone = RegExp(r'^[0-9]{9,15}$').hasMatch(input);
      if (!isPhone) return "Enter a valid phone number".tr();
    }

    return null;
  }

  static String? validateEmailRegister(String? value, String? phoneValue) {
    // // if (value == null || value.trim().isEmpty) {
    // //   return "This field is required";
    // // }
    // bool isEmail = true;
    // if (value != null) {
    //   String input = value.trim();
    //   isEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input);
    // }
    // // bool isPhone = RegExp(r'^[0-9]{10,15}$').hasMatch(input);

    // // if (!isPhone && !isEmail) {
    // if (value != null && !isEmail) {
    //   return "Enter a valid email address";
    // }

    // return null;
    String input = value?.trim() ?? "";
    String phoneInput = phoneValue?.trim() ?? "";

    if (input.isEmpty && phoneInput.isEmpty) {
      return "Please enter either Email or Phone".tr();
    }

    if (input.isNotEmpty) {
      bool isEmail = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(input);
      if (!isEmail) return "Enter a valid email address".tr();
    }

    return null;
  }

  static String? validateEmailOrPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required".tr();
    }

    String input = value.trim();

    bool isPhone = RegExp(r'^[0-9]{10,15}$').hasMatch(input);

    bool isEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input);

    if (!isPhone && !isEmail) {
      return "Enter a valid email address or phone number".tr();
    }

    return null;
  }

  static String? validateReviewAndRequestOrder(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required".tr();
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please select a date".tr();
    }
    return null;
  }

  // static String? validateMinPrice(
  //   String? value,
  //   SearchFilterController controller,
  // ) {
  //   if (value != null &&
  //       value.trim().isNotEmpty &&
  //       controller.maxPriceFilter.value != null &&
  //       int.parse(value) > controller.maxPriceFilter.value!) {
  //     return "hhh";
  //   }
  //   return null;
  // }

  // static String? validateMaxPrice(
  //   String? value,
  //   SearchFilterController controller,
  // ) {
  //   if (value != null &&
  //       value.trim().isNotEmpty &&
  //       controller.minPriceFilter.value != null &&
  //       int.parse(value) < controller.minPriceFilter.value!) {
  //     return "hhh";
  //   }
  //   return null;
  // }

  static String? validateMinPrice(
    String? value,
    SearchFilterController controller,
  ) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final minPrice = int.tryParse(value.trim());
    if (minPrice == null) {
      return "Please enter a valid number".tr();
    }

    if (controller.maxPriceFilter.value != null &&
        minPrice > controller.maxPriceFilter.value!) {
      return "Minimum price cannot be greater than maximum price".tr();
    }

    if (minPrice < 0) {
      return "Price cannot be negative".tr();
    }

    return null;
  }

  static String? validateMaxPrice(
    String? value,
    SearchFilterController controller,
  ) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final maxPrice = int.tryParse(value.trim());
    if (maxPrice == null) {
      return "Please enter a valid number".tr();
    }

    if (controller.minPriceFilter.value != null &&
        maxPrice < controller.minPriceFilter.value!) {
      return "Maximum price cannot be less than minimum price".tr();
    }

    if (maxPrice < 0) {
      return "Price cannot be negative".tr();
    }

    return null;
  }

  static String? validateNumber(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return "$message" + " is required".tr();
    }
    if (!value.isNum) {
      return "The ".tr() + "$message" + " must be in numbers only.".tr();
    }
    return null;
  }

  static String? validateNumberDinamickQuestion(
    String? value,
    String message,
    bool isRequired,
  ) {
    if (isRequired && (value == null || value.trim().isEmpty)) {
      return "$message" + " is required".tr();
    }
     if (value != null && value.isNotEmpty && value.trim().isEmpty) {
      return "Please enter a valid value".tr();
    }

    if (!isRequired && (value == null || value.isEmpty)) {
      return null;
    }
    // if (!isRequired && (value == null || value.trim().isEmpty)) {
    //   return null;
    // }

    // if (value != null && value.trim().isNotEmpty && !value.isNum) {
    //   // if (value.trim().length < 2) {
    //   return "Please enter a valid value";
    //   // }
    // }

    final trimmedValue = value!.trim();
    final number = double.tryParse(trimmedValue);

    if (number == null) {
      return "Please enter a valid number".tr();
    }

    if (number < 0) {
      return "Please enter a valid number".tr();
    }

    return null;
  }

  static String? validateNameArabic(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return "$message" + " is required".tr();
    }
    final arabicRegex = RegExp(r'^[\u0600-\u06FF\s]+$');

    if (!arabicRegex.hasMatch(value)) {
      return "Only Arabic characters are allowed.".tr();
    }
    return null;
  }

  static String? validateNameEnglish(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return "$message" + " is required".tr();
    }
    final englishRegex = RegExp(r'^[a-zA-Z0-9\s]+$');

    if (!englishRegex.hasMatch(value)) {
      return "Only English characters are allowed.".tr();
    }
    return null;
  }

  static String? validateDropDown({int? value, required String type}) {
    // if (value == null || value.trim().isEmpty) {
    if (value == null) {
      return "Please select ".tr() + "$type";
    }
    return null;
  }

  static String? validateNotRequiredButInput(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.trim().isEmpty) {
      return "Please enter a valid value (spaces only are not allowed)".tr();
    }

    return null;
  }
}
