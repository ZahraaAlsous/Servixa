import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart' hide Trans;
// import 'package:file_picker/file_picker.dart';

class BusiessAccountController extends GetxController {
  RxList<File> listImage = <File>[].obs;
  RxList<File> listFile = <File>[].obs;

  // Future<void> pickFile() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       allowMultiple: true,
  //     );

  //     if (result != null) {
  //       List<File> files = result.paths.map((path) => File(path!)).toList();
  //       listFile.addAll(files);
  //     }
  //   } catch (e) {
  //     log('Error picking image: $e');
  //   }
  // }
}
