import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/features/Business_account/data_layer/models/Business_account_model.dart';
import 'package:servixa/features/add%20ads/business_later/add_ads_controller.dart';
import 'package:servixa/features/add%20ads/presentation_layer/widgets/add_ads_business_account_card_widget.dart';

// class BusinessAccountCard extends StatelessWidget {
//   final AddAdsController addAdsController = Get.put(AddAdsController());
//   final BusinessAccountModel account;
//   final VoidCallback onTap;

//   BusinessAccountCard({required this.account, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     // ✅ استخدم Obx هنا عشان يراقب التغييرات
//     return Obx(() {
//       bool isSelected =
//           addAdsController.selectedBusinessAccount.value?.id == account.id;

//       return GestureDetector(
//         onTap: onTap,
//         child: Container(
//           margin: const EdgeInsets.only(bottom: 12),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: isSelected
//                   ? ThemeApp.Foundation_Main_main_500
//                   : ThemeApp.Foundation_Secendary_grey_100,
//               width: isSelected ? 2 : 1,
//             ),
//             color: isSelected ? ThemeApp.Foundation_Main_main_50 : Colors.white,
//           ),
//           child: Row(
//             children: [
//               // // صورة الحساب
//               // Container(
//               //   width: 60,
//               //   height: 60,
//               //   decoration: BoxDecoration(
//               //     borderRadius: BorderRadius.circular(12),
//               //     image: DecorationImage(
//               //       image: AssetImage(ImageApp.profileImageRounded),
//               //       fit: BoxFit.cover,
//               //     ),
//               //   ),
//               // ),
              
//               const SizedBox(width: 16),

//               // تفاصيل الحساب
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       account.businessNameArabic,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       account.typeBusinessAccount,
//                       style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),

//               if (isSelected)
//                 Container(
//                   width: 24,
//                   height: 24,
//                   decoration: const BoxDecoration(
//                     color: ThemeApp.Foundation_Main_main_500,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.check, color: Colors.white, size: 16),
//                 ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }

class FirstStepBusinessAccountWidget extends StatelessWidget {
  final AddAdsController addAdsController = Get.put(AddAdsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: addAdsController.businessAccounts.length,
            // itemCount: 5,
            itemBuilder: (context, index) {
              final account = addAdsController.businessAccounts[index];
              return AddAdsBusinessAccountCardWidget(
                account: account,
                // isSelected: controller.selectedBusinessAccount.value?.id == account.id,
                // isSelected: false,
                onTap: () {
                  addAdsController.selectedBusinessAccount.value = account;
                  // if (!AddAdsController.isBusinessAccountValid()) {
                  if (!addAdsController.isBusinessAccountValid()) {
                    Get.snackbar("ops", "This account not valid");
                  }
                  
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
