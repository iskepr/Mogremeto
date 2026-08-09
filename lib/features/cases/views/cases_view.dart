import "package:flutter/material.dart";

import "../../../core/data/app_data.dart";
import "../../roleplay/views/widgets/card_view.dart";

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
                spacing: MediaQuery.of(context).size.width * 0.06,
                runSpacing: 10,
                children: AppData.cases.map((casee) {
                  final bool isSaved = AppData.doneCasesIds.contains(casee.id);

                  return CardView(
                    title: casee.type,
                    subtitle: casee.title,
                    width: 110,
                    flip: isSaved,
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
