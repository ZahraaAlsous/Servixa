import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servixa/common/widgets/app_outlined_button_widget.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class FourStepBusinessAccountDocumentScreen extends StatelessWidget {
  const FourStepBusinessAccountDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Supporting Documents",
          style: TypographyApp.Title_Mid_Mid.copyWith(
            color: ThemeApp.Foundation_Secendary_grey_600,
          ),
        ),
        // ElevatedButton(onPressed: (){

        // }, child: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     SvgPicture.asset(IconApp.notification),
        //     Text("  Upload Doc")
        //   ],
        // )),
        AppOutlinedButtonWidget(
          textContent: "Upload Doc",
          paddingVertical: 5,
          onPressed: () {},
          icon: IconApp.favorite,
        ),
        AppOutlinedButtonWidget(
          textContent: "Upload Image",
          onPressed: () {},
          icon: IconApp.camera,
        ),
      ],
    );
  }
}
