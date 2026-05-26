import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';

class ProfileImageWidget extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final void Function()? onTap;
  final double? width;
  final double? height;

  ProfileImageWidget({super.key, this.onTap, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? size.width * 0.109,
        height: height ?? 48.6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ThemeApp.Foundation_Secendary_grey_100,
        ),
        child: ClipOval(
          child:
              authController.currentUser.value?.image != null &&
                  authController.currentUser.value!.image!.isNotEmpty
              ? FadeInImage(
                  image: NetworkImage(authController.currentUser.value!.image!),
                  placeholder: const AssetImage(ImageApp.profileImage),
                  fit: BoxFit.cover,
                  width: size.width * 0.109,
                  height: 48.6,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: size.width * 0.109,
                      height: 48.6,
                      color: ThemeApp.Foundation_Secendary_grey_100,
                      child: const Icon(
                        Icons.broken_image,
                        size: 30,
                        color: Colors.grey,
                      ),
                    );
                  },
                )
              : Image.asset(
                  ImageApp.profileImage,
                  fit: BoxFit.cover,
                  width: size.width * 0.109,
                  height: 48.6,
                ),
        ),
      ),
    );
  }
}
