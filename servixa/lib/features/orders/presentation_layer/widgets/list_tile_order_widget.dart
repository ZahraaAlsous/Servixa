import 'package:flutter/material.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class ListTileOrderWidget extends StatelessWidget {
  final String title;
  final String trailing;
  ListTileOrderWidget({super.key, required this.title, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      visualDensity: const VisualDensity(vertical: -4),
      minVerticalPadding: 0,
      title: Text(
        title,
        style: TypographyApp.Title_Mid_Mid.copyWith(color: ThemeApp.black),
      ),
      trailing: Text(
        trailing,
        maxLines: 3,
        style: TypographyApp.Title_Mid_Mid.copyWith(
          color: ThemeApp.Foundation_Secendary_grey_300,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
