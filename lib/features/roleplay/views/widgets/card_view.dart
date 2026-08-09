import "dart:math" as math;

import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class CardView extends StatefulWidget {
  const CardView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.flip,
    this.width,
    this.onFlip,
  });

  final String title;
  final String subtitle;
  final double? width;
  final bool flip;
  final VoidCallback? onFlip;

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  double get width => widget.width ?? 225;
  double get height => width * 1.3;
  double get padding => width * 0.04;
  double get fontSize => (width * 0.13).clamp(20, 50);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onFlip,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          final rotate = Tween(begin: 0.0, end: 1.0).animate(animation);
          return AnimatedBuilder(
            animation: rotate,
            builder: (context, child) {
              final angle = rotate.value * math.pi;
              final isFlipped = rotate.value >= 0.5;

              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(angle)
                  ..rotateZ((math.Random().nextDouble() - 0.5) * 1),
                child: isFlipped
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: child,
                      )
                    : child,
              );
            },
            child: child,
          );
        },
        child: widget.flip ? _buildFrontCard() : _buildBackCard(),
      ),
    );
  }

  Widget _buildFrontCard() {
    return Container(
      key: const ValueKey(true),
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(padding * 2),
        border: Border.all(color: const Color(0xFF822222)),
        color: const Color(0xFFFFF0CC),
      ),
      child: Stack(
        children: [
          Positioned(
            top: padding,
            left: padding,
            child: SvgPicture.asset(
              "assets/imgs/cornerTL.svg",
              width: width * 0.26,
            ),
          ),
          Positioned(
            bottom: padding,
            right: padding,
            child: SvgPicture.asset(
              "assets/imgs/cornerBR.svg",
              width: width * 0.26,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: const Color(0xFF228272),
                    fontSize: fontSize,
                  ),
                ),
                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF822222),
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      key: const ValueKey(false),
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(padding * 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        color: const Color(0xFF822222),
      ),
      child: SvgPicture.asset("assets/imgs/logo.svg", width: width),
    );
  }
}
