import 'package:flutter/material.dart';
import 'package:servixa/core/const/dimens_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class HomeCardCategoryWidget extends StatelessWidget {
  String assetName;
  String categoryName;
  bool? margin;
  void Function()? onTap;
  TextStyle? typographyApp;
  HomeCardCategoryWidget({
    super.key,
    required this.assetName,
    required this.categoryName,
    this.typographyApp,
    this.margin,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: 
        margin == null
            ? EdgeInsetsGeometry.zero
            : EdgeInsetsGeometry.symmetric(
              // edit
              // إذا ضفت padding أو margin للصفحة كاملة  ما يتأثر الطرف الأول من الناصر مع طرف الصفحة
                horizontal: size.width * (DimensApp.gapBetweenCategoryCard /2),
              ),
        padding: EdgeInsetsGeometry.all(10),
        width: size.width * 0.279,
        // height: size.height * 0.090,
        height: 84,
        decoration: BoxDecoration(
          color: ThemeApp.Foundation_Main_main_50,
          // color: const Color.fromARGB(255, 235, 144, 26),
          borderRadius: BorderRadius.circular(41),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // edit
            // لازم بعدين حطها networq
            // لازم حط عرض و طول أو اعمل شي لل صورة؟
            Image(image: AssetImage(assetName), width: 34, height: 34),
            Text(
              categoryName,
              textAlign: TextAlign.center,
              // note
              maxLines: 2,
              style: typographyApp?? TypographyApp.Body_mid_Mid.copyWith(
                
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
