import 'package:get/get.dart';

enum AccountType { regular, business }

class ProfileConttroller extends GetxController {
  var selectedAdType = AccountType.regular.obs;
}
