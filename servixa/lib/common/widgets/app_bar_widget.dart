import 'package:flutter/material.dart';
import 'package:servixa/core/const/theme_app.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? child;
  final Widget? title;
  final double? toolbarHeight;
  AppBarWidget({super.key, this.child, this.title, this.toolbarHeight});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: toolbarHeight ?? kToolbarHeight,
      title: title,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ThemeApp.linearBackground, ThemeApp.whiteBackground],
          ),
        ),
        child: child,
      ),
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}
