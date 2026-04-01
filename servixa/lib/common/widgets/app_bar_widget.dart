import 'package:flutter/material.dart';
import 'package:servixa/core/const/theme_app.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? child;
  final Widget? title;
  AppBarWidget({super.key, this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
