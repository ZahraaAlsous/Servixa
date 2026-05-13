import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:servixa/features/report%20an%20ad/data_layer/sourses/report_service.dart';

class ReportController extends GetxController {
  final ReportService reportService = ReportService();
  RxBool isSendReport = false.obs;
  TextEditingController textReportController = TextEditingController();
  Future<void> addReport(
    int adId,
    void Function() onSuccess,
    void Function(String e) onError,
  ) async {
    try {
      isSendReport.value = true;
      await reportService.addReport(
        adId: adId,
        textReport: textReportController.text,
      );
      onSuccess();
    } catch (e) {
      onError(e.toString());
    } finally {
      isSendReport.value = false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textReportController.dispose();
    super.dispose();
  }
}
