// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:servixa/core/const/icon_app.dart';
// import 'package:servixa/core/const/theme_app.dart';
// import 'package:servixa/core/const/typography_app.dart';

// class BottomSheetViewProfileWidget extends StatelessWidget {
//   const BottomSheetViewProfileWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Container(
//       height: size.height * 0.7,
//       decoration: BoxDecoration(
//         color: ThemeApp.whiteBackground,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(40),
//           topRight: Radius.circular(40),
//         ),
//       ),
//       child: Column(
//         children: [
//           _buildHeader(),
//           Divider(
//             thickness: 8,
//             color: ThemeApp.Foundation_Secendary_grey_50,
//             height: 30,
//           ),

//           SizedBox(
//             width: size.width * 0.9,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: ThemeApp.Foundation_Main_main_500,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadiusGeometry.circular(16),
//                 ),
//               ),
//               // edit
//               onPressed: () {},
//               child: Text(
//                 "Continue",
//                 style: TypographyApp.Body_mid_Mid.copyWith(
//                   color: ThemeApp.Foundation_Main_yellow_50,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: EdgeInsets.all(16),
//       child: Row(
//         children: [
//           SvgPicture.asset(
//             IconApp.catalogAlt,
//             width: 25,
//             height: 25,
//             color: ThemeApp.Foundation_Main_main_300,
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               "Chose Account",
//               style: TypographyApp.Title_larg_Mid.copyWith(
//                 color: ThemeApp.Foundation_Grey_grey_700,
//               ),
//             ),
//           ),
//           IconButton(
//             onPressed: () => Get.back(),
//             icon: SvgPicture.asset(
//               IconApp.cancel,
//               width: 32,
//               height: 32,
//               color: ThemeApp.Foundation_Secendary_grey_400,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/features/Business_account/presentation_layer/screens/create_business_account_screen.dart';
import 'package:servixa/features/profile/presentation_layer/screens/edit_profile_screen.dart';

class BottomSheetViewProfileWidget extends StatelessWidget {
  const BottomSheetViewProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Container(
        // height: size.height * 0.7,
        decoration: const BoxDecoration(
          color: ThemeApp.whiteBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(ImageApp.profileImageRounded),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ahmad Mohammad",
                          style: TypographyApp.Title_Mid_Mid.copyWith(
                            color: ThemeApp.black,
                          ),
                        ),
                        Text(
                          "Membership Expire Date : 2026/5/5",
                          style: TypographyApp.Label_Mid_Mid.copyWith(
                            color: ThemeApp.Foundation_Secendary_grey_300,
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Get.to(CreateBusinessAccountScreen());
                          },
                          child: Text(
                            "Create Business Account",
                            style: TypographyApp.Label_Mid_Regular,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 50,
                    height: 34,
                    decoration: BoxDecoration(
                      color: ThemeApp.Foundation_Main_main_100,
                      borderRadius: BorderRadius.circular(6),
                    ),

                    child: IconButton(
                      onPressed: () {
                        Get.to(EditProfileScreen());
                      },
                      icon: SvgPicture.asset(
                        // edit
                        IconApp.edit,
                        color: ThemeApp.Foundation_Main_main_500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
              color: ThemeApp.Foundation_Secendary_grey_50,
              height: 30,
            ),

            Text(
              "User Information",
              style: TypographyApp.Title_larg_Mid.copyWith(
                color: ThemeApp.black,
              ),
            ),
            _buildListTile("Arabic Name : ", IconApp.person, "احمد محمد"),
            _buildListTile("English Name : ", IconApp.person, "Ahmad Mohammad"),
            // edit
            // icon
            _buildListTile("City :", IconApp.person, "Newyork , USA"),
            // edit
            // icon
            _buildListTile(
              "Address :",
              IconApp.person,
              "Building 15 , Sreet gold 12",
            ),
            const Divider(
              thickness: 8,
              color: ThemeApp.Foundation_Secendary_grey_50,
              height: 30,
            ),
            _buildListTileContactInfo(
              "Email :",
              IconApp.email,
              "Ahmad@gmail.com",
            ),
            // edit
            // icon
            _buildListTileContactInfo(
              "Phone Number :",
              IconApp.phone,
              "+966 4523656",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          SvgPicture.asset(
            // edit
            IconApp.catalogAlt,
            width: 25,
            height: 25,
            color: ThemeApp.Foundation_Main_main_300,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "View Profile",
              style: TypographyApp.Title_larg_Mid.copyWith(
                color: ThemeApp.Foundation_Grey_grey_700,
              ),
            ),
          ),
          IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset(
              IconApp.cancel,
              width: 32,
              height: 32,
              color: ThemeApp.Foundation_Secendary_grey_400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, String iconLeading, String trailing) {
    return ListTile(
      title: Text(
        title,
        style: TypographyApp.Title_Mid_Mid.copyWith(color: ThemeApp.black),
      ),
      leading: SvgPicture.asset(iconLeading),
      trailing: Text(
        trailing,
        style: TypographyApp.Body_mid_Mid.copyWith(
          color: ThemeApp.Foundation_Secendary_grey_300,
        ),
      ),
    );
  }

  Widget _buildListTileContactInfo(
    String title,
    String iconLeading,
    String trailing,
  ) {
    return ListTile(
      title: Text(
        title,
        style: TypographyApp.Title_Mid_Mid.copyWith(color: ThemeApp.black),
      ),
      // edit
      leading: SvgPicture.asset(iconLeading),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            trailing,
            style: TypographyApp.Body_mid_Mid.copyWith(
              color: ThemeApp.Foundation_Secendary_grey_300,
            ),
          ),
          // edit
          Icon(Icons.done),
        ],
      ),
    );
  }
}
