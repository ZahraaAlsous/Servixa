import 'package:flutter/material.dart';
import 'package:servixa/features/search_filter/business_later/search_filter_controller.dart';
import 'package:get/get.dart';

class Validators {
  final SearchFilterController searchFilterController = Get.put(
    SearchFilterController(),
  );
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    String email = value.trim();
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return "Enter a valid email address";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number";
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain at least one special character";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return "Confirm password is required";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }

  static String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "First name is required";
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Last name is required";
    }
    return null;
  }

  static String? validateEmailOrPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }

    String input = value.trim();

    bool isPhone = RegExp(r'^[0-9]{10,15}$').hasMatch(input);

    bool isEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input);

    if (!isPhone && !isEmail) {
      return "Enter a valid email address or phone number";
    }

    return null;
  }

  static String? validateReviewAndRequestOrder(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please select a date";
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
    // إذا كان الحقل فارغاً، لا مشكلة
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final minPrice = int.tryParse(value.trim());
    if (minPrice == null) {
      return "Please enter a valid number";
    }

    if (controller.maxPriceFilter.value != null &&
        minPrice > controller.maxPriceFilter.value!) {
      return "Minimum price cannot be greater than maximum price";
    }

    if (minPrice < 0) {
      return "Price cannot be negative";
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
      return "Please enter a valid number";
    }

    if (controller.minPriceFilter.value != null &&
        maxPrice < controller.minPriceFilter.value!) {
      return "Maximum price cannot be less than minimum price";
    }

    if (maxPrice < 0) {
      return "Price cannot be negative";
    }

    return null;
  }
}
