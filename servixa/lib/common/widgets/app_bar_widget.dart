import 'package:flutter/material.dart';
import 'package:servixa/core/const/theme_app.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ThemeApp.linearBackground, ThemeApp.whiteBackground],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
