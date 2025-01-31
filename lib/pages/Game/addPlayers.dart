import 'package:flutter/material.dart';
import 'package:mafuso/pages/Game/setCharacter.dart';
import 'package:mafuso/widgets/button.dart';
import 'package:mafuso/widgets/input.dart';

class AddPlayers extends StatefulWidget {
  const AddPlayers({super.key});

  @override
  State<AddPlayers> createState() => _AddPlayersState();
}

class _AddPlayersState extends State<AddPlayers> {
  // نقل المتحكمات هنا لتجنب إعادة الإنشاء
  final player1 = TextEditingController();
  final player2 = TextEditingController();
  final player3 = TextEditingController();
  final player4 = TextEditingController();

  @override
  void dispose() {
    // تنظيف المتحكمات عند التخلص من الويدجيت
    player1.dispose();
    player2.dispose();
    player3.dispose();
    player4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF822222),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    'ادخل اسماء اللاعبين',
                    style: TextStyle(color: Color(0xFFFFF0CC), fontSize: 40),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Input(title: "اللاعب الاول", controller: player1),
                    Input(title: "اللاعب الثاني", controller: player2),
                    Input(title: "اللاعب الثالث", controller: player3),
                    Input(title: "اللاعب الرابع", controller: player4),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Button(
                    title: 'أبدأ التحقيق',
                     page:SetCharacter(
                                player1: player1.text,
                                player2: player2.text,
                                player3: player3.text,
                                player4: player4.text,
                              ), 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
