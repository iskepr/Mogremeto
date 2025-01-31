import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Input extends StatelessWidget {
  const Input({super.key, required this.title, required this.controller});
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFF0CC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF822222)),
      ),
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 5,
              child: SvgPicture.asset('assets/imgs/cornerTL.svg', width: 50),
            ),
            Positioned(
              bottom: 0,
              right: 5,
              child: SvgPicture.asset('assets/imgs/cornerBR.svg', width: 50),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: controller,
                autofocus: true,
                style: TextStyle(fontSize: 30, color: Color(0xFF822222)),
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixText: ' : $title',
                  suffixStyle: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF822222),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
