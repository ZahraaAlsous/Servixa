import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:servixa/core/const/icon_app.dart';
import 'package:servixa/core/const/theme_app.dart';

class FavoriteAnimatedButton extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const FavoriteAnimatedButton({
    super.key,
    required this.isFavorite,
    required this.onTap,
  });

  @override
  State<FavoriteAnimatedButton> createState() => _FavoriteAnimatedButtonState();
}

class _FavoriteAnimatedButtonState extends State<FavoriteAnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200), // مدة النبضة
      vsync: this,
    );

    // تسلسل الحركة: تكبير إلى 1.3 ثم العودة إلى 1.0 بنعومة
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 1.5,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.5,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant FavoriteAnimatedButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // إذا تغيرت الحالة إلى "مفضلة"، قم بتشغيل حركة النبض فوراً
    if (widget.isFavorite != oldWidget.isFavorite && widget.isFavorite) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: IconButton(
        onPressed: widget.onTap,
        icon: SvgPicture.asset(
          widget.isFavorite ? IconApp.favorite : IconApp.favoriteBorder,
          color: widget.isFavorite
              ? ThemeApp.Foundation_Main_main_400
              : ThemeApp.black,
        ),
      ),
    );
  }
}
