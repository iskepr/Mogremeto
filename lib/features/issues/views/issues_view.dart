import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../core/data/app_data.dart";

class IssuesView extends StatelessWidget {
  const IssuesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF822222),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "جميع القضايا",
                style: TextStyle(fontSize: 40, color: Color(0xFFFFF0CC)),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: AppData.cases.map((issue) {
                  final bool isSaved = AppData.doneCasesIds.contains(issue.id);

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF822222)),
                      color: const Color(0xFFFFF0CC),
                    ),
                    width: 100,
                    height: 120,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 10,
                          child: SvgPicture.asset(
                            "assets/imgs/cornerTL.svg",
                            width: 30,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: SvgPicture.asset(
                            "assets/imgs/cornerBR.svg",
                            width: 30,
                          ),
                        ),
                        Center(
                          child: Text(
                            issue.type,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSaved
                                  ? const Color(0xFF822222)
                                  : const Color(0xFF228272),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
