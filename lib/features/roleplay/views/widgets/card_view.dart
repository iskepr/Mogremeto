import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class CardView extends StatelessWidget {
  const CardView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.flip,
    required this.onFlip,
  });

  final String title;
  final String subtitle;
  final bool flip;
  final VoidCallback onFlip;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFlip,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final rotate = Tween(begin: 0.0, end: 1.0).animate(animation);
          return AnimatedBuilder(
            animation: rotate,
            builder: (context, child) {
              final angle = rotate.value * 3.1416;
              final isFlipped = rotate.value >= 0.5;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(angle),
                child: isFlipped
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(3.1416),
                        child: child,
                      )
                    : child,
              );
            },
            child: child,
          );
        },
        child: flip
            ? Container(
                key: const ValueKey(
                  true,
                ), // <-- المفتاح يضمن تحديث الواجهة عند تغيير `flip`
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF822222)),
                  color: const Color(0xFFFFF0CC),
                ),
                width: 225,
                height: 300,
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 10,
                      child: SvgPicture.asset(
                        "assets/imgs/cornerTL.svg",
                        width: 60,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: SvgPicture.asset(
                        "assets/imgs/cornerBR.svg",
                        width: 60,
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Color(0xFF228272),
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF822222),
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                key: const ValueKey(
                  false,
                ), // <-- المفتاح يضمن تحديث الواجهة عند تغيير `flip`
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF822222),
                ),
                width: 225,
                height: 300,
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset("assets/imgs/logo.svg", width: 250),
              ),
      ),
    );
  }
}
