import 'package:get/get.dart';
import 'package:servixa/features/setting/data_layer/models/policy_model.dart';
import 'package:servixa/features/setting/data_layer/sourses/policy_service.dart';

class PolicyController extends GetxController {
  final PolicyService _policyService = PolicyService();
  RxBool isLoadingPolicies = false.obs;
  RxBool hasError = false.obs;
  RxInt selectedTabIndex = 0.obs;
  List<PolicyModel> policies = [];

  Future<void> loadPolicies() async {
    try {
      isLoadingPolicies.value = true;
      hasError.value = false;
      policies = await _policyService.getPolicies();
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoadingPolicies.value = false;
    }
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
