import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';
import 'package:servixa/common/widgets/app_text_form_field_widget.dart';
import 'package:servixa/core/utils/validators.dart';
import 'package:servixa/common/widgets/app_text_area_widget.dart';

class BottomSheetAddOrderWidget extends StatelessWidget {
  BottomSheetAddOrderWidget({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: ThemeApp.whiteBackground,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SvgPicture.asset(
                        IconApp.catalogAlt,
                        width: 25,
                        height: 25,
                        color: ThemeApp.Foundation_Main_main_300,
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Text(
                        "Request Catalog",
                        style: TypographyApp.Title_larg_Mid.copyWith(
                          color: ThemeApp.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: SvgPicture.asset(
                          IconApp.cancel,
                          width: 32,
                          height: 32,
                          color: ThemeApp.Foundation_Secendary_grey_400,
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ),

              // const SizedBox(height: 20),
              Expanded(
                flex: 1,
                child: Text(
                  "Need By Date",
                  style: TypographyApp.Title_Mid_Mid.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // const SizedBox(height: 8),
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: dateController,
                  readOnly: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hint: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // note
                        // فيها مشكلة من ال figma
                        // SvgPicture.asset(
                        //   IconApp.clarityDateLine,
                        //   width: 18,
                        //   height: 18,
                        //   color: ThemeApp.Foundation_Main_main_500,
                        // ),
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 18,
                          color: ThemeApp.Foundation_Main_main_500,
                        ),
                        Text(
                          " Select date",
                          style: TypographyApp.Body_mid_Regular.copyWith(
                            color: ThemeApp.Foundation_Secendary_grey_200,
                          ),
                        ),
                      ],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        width: 1,
                        color: ThemeApp.Foundation_Secendary_grey_100,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        width: 1,
                        color: ThemeApp.Foundation_Secendary_grey_100,
                      ),
                    ),

                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: ThemeApp.Foundation_Main_main_500,
                              onPrimary: ThemeApp.Foundation_Main_main_50,
                              surface: ThemeApp.whiteBackground,
                              onSurface: ThemeApp.Foundation_Main_main_500,
                            ),
                            dialogBackgroundColor: ThemeApp.whiteBackground,
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedDate != null) {
                      // ✅ تنسيق التاريخ وعرضه في الحقل
                      dateController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    }
                  },

                  validator: Validators.validateDate,
                  // (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return "Please select a date";
                  //   }
                  //   return null;
                  // },
                ),
              ),

              Expanded(
                flex: 1,
                child: Text(
                  "Quantity",
                  style: TypographyApp.Body_mid_Mid.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: AppTextFormField(
                  hintText: "Quantity",
                  icon: IconApp.quantity,
                  keyboardType: TextInputType.number,
                  // edit
                  validator: Validators.validateReviewAndRequestOrder,
                  controller: quantityController,
                ),
              ),

              Expanded(
                flex: 1,
                child: Text(
                  "Details",
                  style: TypographyApp.Body_mid_Mid.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Expanded(
                flex: 4,
                child: AppTextAreaWidget(
                  hintText: "Enter Details",
                  prefixIcon: IconApp.details,
                  controller: detailsController,
                ),
              ),

              // const SizedBox(height: 20),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: ThemeApp.Foundation_Main_main_500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () => Get.back(),
                        child: Text(
                          "Cancel",
                          style: TypographyApp.Body_mid_Mid.copyWith(
                            color: ThemeApp.Foundation_Main_main_500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeApp.Foundation_Main_main_500,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // ✅ هنا منطق إضافة الطلب
                            print('Date: ${dateController.text}');
                            // Get.back(); // إذا بدك تقفل بعد الإرسال
                          }
                        },
                        child: Text(
                          "Submit",
                          style: TypographyApp.Body_mid_Mid.copyWith(
                            color: ThemeApp.Foundation_Main_yellow_50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
