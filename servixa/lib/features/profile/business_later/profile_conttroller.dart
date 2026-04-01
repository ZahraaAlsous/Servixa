import 'package:get/get.dart' hide Trans;

enum AccountType { regular, business }

class ProfileConttroller extends GetxController {
  var selectedAdType = AccountType.regular.obs;
}
