import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/common/widgets/app_bar_widget.dart';
import 'package:servixa/common/widgets/app_rich_text_widget.dart';
import 'package:servixa/common/widgets/app_snackbar.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:servixa/common/widgets/loading_animation_widget.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/core/services/image_service.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/profile/business_later/profile_controller.dart';

class EditProfileScreen extends GetView<ProfileController> {
  final TextEditingController addressDetailsController =
      TextEditingController();
  final ProfileController profileController = Get.put(ProfileController());
  final AuthController authController = Get.put(AuthController());
  EditProfileScreen({super.key}) {
    Get.find<ProfileController>().initialDataEditProfile();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        profileController.selectedImage.value = null;
        return true;
      },
      child: Scaffold(
        backgroundColor: ThemeApp.whiteBackground,
        appBar: AppBarWidget(),
        body: SingleChildScrollView(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: size.width * DimensApp.spaceHorizontalScreen,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppRichTextWidget(
                firstText: "Update ",
                secondText: "Profile",
                typographyApp: TypographyApp.Title_larg_Mid,
              ),
              SizedBox(height: DimensApp.spaceBetweenTitleAndDetails),

              // Center(
              //   child: Stack(
              //     children: [
              //       Obx(
              //         () => CircleAvatar(
              //           radius: 60,
              //           backgroundImage:
              //               profileController.selectedImage.value != null
              //               ? FileImage(profileController.selectedImage.value!)
              //               : (authController.currentUser.value!.image!.isNotEmpty
              //                     ? NetworkImage(
              //                         authController.currentUser.value!.image!,
              //                       )
              //                     : null),
              //           child:
              //               authController.currentUser.value!.image!.isEmpty &&
              //                   profileController.selectedImage.value == null
              //               ? const Icon(Icons.person, size: 60)
              //               : null,
              //         ),
              //       ),
              //       Positioned(
              //         bottom: 0,
              //         right: 0,
              //         child: CircleAvatar(
              //           radius: 18,
              //           backgroundColor: const Color.fromARGB(255, 102, 102, 102),
              //           child: IconButton(
              //             icon: Icon(
              //               Icons.camera_alt,
              //               size: 15,
              //               color: Colors.white,
              //             ),
              //             // onPressed: _pickImage,
              //             onPressed: () => ImageService.pickImage(
              //               profileController.selectedImage,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Center(
                child: Stack(
                  children: [
                    Obx(
                      () => ClipOval(
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ThemeApp.Foundation_Secendary_grey_100,
                          ),
                          child: _buildProfileImage(),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: const Color.fromARGB(
                          255,
                          102,
                          102,
                          102,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 15,
                            color: Colors.white,
                          ),
                          onPressed: () => ImageService.pickImage(
                            profileController.selectedImage,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DimensApp.hightBetweenTextFormField),

              Row(
                children: [
                  AppTextFormField(
                    labelText: "First Name",
                    hintText: "Ahmad",
                    icon: IconApp.person,
                    widthTextFormField: 0.444,
                    controller: profileController.firstNameController,
                    validator: (value) =>
                        Validators.validateText(value, "First Name".tr()),
                  ),
                  const SizedBox(width: DimensApp.widthBetweenTextFormField),
                  AppTextFormField(
                    labelText: "Last Name",
                    hintText: "Ahmad",
                    icon: IconApp.person,
                    widthTextFormField: 0.444,
                    controller: profileController.lastNameController,
                    validator: (value) =>
                        Validators.validateText(value, "Last name".tr()),
                  ),
                ],
              ),
              const SizedBox(height: DimensApp.hightBetweenTextFormField),

              AppTextFormField(
                labelText: "Email Address",
                hintText: "example@gmail.com",
                keyboardType: TextInputType.emailAddress,
                icon: IconApp.email,
                controller: profileController.emailController,
                validator: (value) => Validators.validateEmailRegister(
                  value,
                  profileController.phoneController.text,
                ),
              ),
              const SizedBox(height: DimensApp.hightBetweenTextFormField),
              AppTextFormField(
                labelText: "Phone Number",
                hintText: "+963 11111111",
                keyboardType: TextInputType.phone,
                // edit
                // icon
                icon: IconApp.phone,
                controller: profileController.phoneController,
                validator: (value) => Validators.validatePhoneRegister(
                  value,
                  profileController.emailController.text,
                ),
              ),
              // const SizedBox(height: DimensApp.hightBetweenTextFormField),
              // AppDropdownButtonFormFieldWidget(
              //   hintText: "City",
              //   // edit
              //   onChanged: (value) {
              //     // addAdsController.typeService = value;
              //   },
              //   // edit
              //   prefixIcon: IconApp.city,
              //   borderRadio: 16,
              //   // edit
              //   // validator: Validators.validateReviewAndRequestOrder,
              //   // edit
              //   items: [
              //     DropdownMenuItem<String>(
              //       value: "dolar",
              //       child: Text(
              //         "Dollar \$",
              //         style: TypographyApp.Body_mid_Mid.copyWith(
              //           color: ThemeApp.Foundation_Secendary_grey_400,
              //         ),
              //       ),
              //       alignment: Alignment.center,
              //     ),

              //     DropdownMenuItem<String>(
              //       value: "sp",
              //       child: Text(
              //         "Sp Syrian pounds",
              //         style: TypographyApp.Body_mid_Mid.copyWith(
              //           color: ThemeApp.Foundation_Secendary_grey_400,
              //         ),
              //       ),
              //       alignment: Alignment.center,
              //     ),
              //   ],
              // ),

              // const SizedBox(height: DimensApp.hightBetweenTextFormField),
              // Row(
              //   children: [
              //     SvgPicture.asset(
              //       IconApp.place,
              //       color: ThemeApp.Foundation_Main_main_500,
              //     ),
              //     // edit
              //     Text(
              //       "742 Evergreen Terrace, Springfield",
              //       style: TypographyApp.Body_mid_Regular.copyWith(
              //         color: ThemeApp.Foundation_Secendary_grey_300,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: DimensApp.hightBetweenTextFormField),

              // AppMapWidget(),
              // const SizedBox(height: DimensApp.hightBetweenTextFormField),

              // AppTextAreaWidget(
              //   hintText: "Address Detail",
              //   // edit
              //   prefixIcon: IconApp.Balconies,
              //   controller: addressDetailsController,
              //               validate: Validators.validateReviewAndRequestOrder,

              // ),
              const SizedBox(height: DimensApp.hightBetweenTextFormField),
              Obx(() {
                if (profileController.isLoading.value) {
                  // return Center(child: CircularProgressIndicator());
                  return LoadingAnimationWidget(message: "Wait please...".tr());
                }
                return SizedBox(
                  width: size.width * 0.93,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: ThemeApp.Foundation_Main_main_500,
                    ),
                    onPressed: () {
                      profileController.updateProfile(
                        (isUpdate) {
                          Get.back();
                          AppSnackbar.showSuccess(
                            isUpdate
                                ? "Profile information has been successfully updated"
                                      .tr()
                                : "None of the fields have been changed.".tr(),
                          );
                        },
                        (e) {
                          AppSnackbar.showError(e);
                        },
                      );
                    },

                    child: Text(
                      "Update".tr(),
                      style: TypographyApp.Body_mid_Mid.copyWith(
                        color: ThemeApp.Foundation_Main_yellow_50,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    if (profileController.selectedImage.value != null) {
      return Image.file(
        profileController.selectedImage.value!,
        fit: BoxFit.cover,
        width: 120,
        height: 120,
      );
    }

    final imageUrl = authController.currentUser.value?.image;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return
      // FadeInImage(
      //   image: NetworkImage(imageUrl),
      //   placeholder: const AssetImage(ImageApp.placeholder),
      //   fit: BoxFit.cover,
      //   width: 120,
      //   height: 120,
      //   imageErrorBuilder: (context, error, stackTrace) {
      //     return Container(
      //       width: 120,
      //       height: 120,
      //       color: ThemeApp.Foundation_Secendary_grey_100,
      //       child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
      //     );
      //   },
      // );
      CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) =>
            Image.asset(ImageApp.placeholder, fit: BoxFit.cover),
        fit: BoxFit.cover,
        width: 120,
        height: 120,
        errorWidget: (context, url, error) {
          return Container(
            width: 120,
            height: 120,
            color: ThemeApp.Foundation_Secendary_grey_100,
            child: const Icon(Icons.broken_image, size: 30, color: Colors.grey),
          );
        },
        fadeInDuration: Duration(seconds: 1),
        fadeOutDuration: Duration(seconds: 1),
        placeholderFadeInDuration: Duration(seconds: 1),
      );
    }

    return Image.asset(
      ImageApp.profileImage,
      fit: BoxFit.cover,
      width: 120,
      height: 120,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 120,
          height: 120,
          color: ThemeApp.Foundation_Secendary_grey_100,
          child: const Icon(Icons.person, size: 50, color: Colors.grey),
        );
      },
    );
  }
}
