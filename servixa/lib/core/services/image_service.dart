import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static Future<void> pickImage(Rx<File?> file) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        file.value = File(pickedFile.path); // ✅ استبدال الصورة
        log('Main image selected: ${pickedFile.path}');
      }
    } catch (e) {
      log('Error picking main image: $e');
    }
  }

  static Future<void> pickMultipleSubImages(RxList<File> list) async {
    try {
      final picker = ImagePicker();
      final List<XFile>? pickedFiles = await picker.pickMultiImage(
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        for (var file in pickedFiles) {
          list.add(File(file.path));
        }
        list.refresh();
        log('Added ${pickedFiles.length} sub images. Total: ${list.length}');
      }
    } catch (e) {
      log('Error picking sub images: $e');
    }
  }
}
