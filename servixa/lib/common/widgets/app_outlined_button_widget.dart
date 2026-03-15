import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servixa/core/const/icon_app.dart';

class AppOutlinedButtonWidget extends StatelessWidget {
  String textContent;
  void Function()? onPressed;
  bool isRow;
  AppOutlinedButtonWidget({
    super.key,
    required this.textContent,
    required this.onPressed,
    required this.isRow,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: isRow
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(IconApp.camera),
                  Text(textContent, style: TextStyle(color: Colors.amber)),
                ],
              )
            : Column(
                children: [
                  SvgPicture.asset(IconApp.camera),
                  Text(textContent, style: TextStyle(color: Colors.amber)),
                ],
              ),
      ),
    );
  }
}
