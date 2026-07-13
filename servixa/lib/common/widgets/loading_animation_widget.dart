import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:servixa/core/const/image_app.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/core/const/typography_app.dart';

class LoadingAnimationWidget extends StatefulWidget {
  final String? message;
  final Color? backgroundColor;
  final Color? loaderColor;
  final bool? showLogo;
  final bool showText;

  const LoadingAnimationWidget({
    super.key,
    this.message,
    this.backgroundColor,
    this.loaderColor,
    this.showLogo,
    this.showText = true,
  });

  @override
  State<LoadingAnimationWidget> createState() => _LoadingAnimationWidgetState();
}

class _LoadingAnimationWidgetState extends State<LoadingAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _fadeAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.showLogo ?? false)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              widget.loaderColor?.withOpacity(0.1) ??
                              ThemeApp.Foundation_Main_main_100,
                        ),
                        child: Center(
                          child: Image(image: AssetImage(ImageApp.loading)),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          if (widget.showLogo ?? false) const SizedBox(height: 30),
          if (widget.showText)
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              builder: (context, double opacity, child) {
                return Opacity(opacity: opacity, child: child);
              },
              child: Text(
                widget.message ?? "Loading...".tr(),
                style: TypographyApp.Body_mid_Mid.copyWith(
                  color: ThemeApp.Foundation_Secendary_grey_300,
                ),
              ),
            ),
          if (widget.showText) const SizedBox(height: 10),

          _buildLoadingDots(),
        ],
      ),
    );
  }

  Widget _buildLoadingDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final value = (_controller.value * 3 + index) % 3;
            final opacity = value > 0.5 ? 1.0 : 0.3;
            final size = value > 0.5 ? 10.0 : 8.0;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (widget.loaderColor ?? ThemeApp.Foundation_Main_main_500)
                    .withOpacity(opacity),
              ),
            );
          },
        );
      }),
    );
  }
}
