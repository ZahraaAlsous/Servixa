import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart' hide Trans;
import 'package:file_picker/file_picker.dart';
import 'package:open_filex/open_filex.dart';

class BusiessAccountController extends GetxController {
  RxList<File> listImage = <File>[].obs;
  RxList<File> listFile = <File>[].obs;

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc'],
      );

      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        listFile.addAll(files);
      }
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  void deleteFile(int idFile) {
    listFile.removeAt(idFile);
  }

  void openFile(String filePath) async {
    try {
      // هذه الدالة تفتح الملف بناءً على مساره وتختار التطبيق المناسب تلقائياً
      final result = await OpenFilex.open(filePath);

      if (result.type != ResultType.done) {
        // إذا فشل فتح الملف (مثلاً لا يوجد تطبيق يفتح PDF)
        Get.snackbar(
          "Error",
          result.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      log('Error opening file: $e');
    }
  }
}
