import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.title, required this.page,});
  final String title;
  final Widget page;
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFF0CC),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xFF822222)),
        ),
        width: 300,
        height: 70,
        margin: EdgeInsets.symmetric(vertical: 5),
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
              Center(
                child: Text(
                  title,
                  style: TextStyle(color: Color(0xFF822222), fontSize: 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
