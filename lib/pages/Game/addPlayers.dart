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

  // دالة للتحقق من الحقول
  bool validateFields() {
    return player1.text.isNotEmpty &&
        player2.text.isNotEmpty &&
        player3.text.isNotEmpty &&
        player4.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF822222),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  'ادخل اسماء اللاعبين',
                  style: TextStyle(color: Color(0xFFFFF0CC), fontSize: 40),
                ),
              ),

              Column(
                children: [
                  Input(title: "اللاعب الاول", controller: player1),
                  Input(title: "اللاعب الثاني", controller: player2),
                  Input(title: "اللاعب الثالث", controller: player3),
                  Input(title: "اللاعب الرابع", controller: player4),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Button(
                    title: 'أبدأ التحقيق',
                    onTap: () {
                      // التحقق من الحقول
                      if (validateFields()) {
                        // الانتقال إلى صفحة SetCharacter إذا كانت الحقول صالحة
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => SetCharacter(
                                  player1: player1.text,
                                  player2: player2.text,
                                  player3: player3.text,
                                  player4: player4.text,
                                ),
                          ),
                        );
                      } else {
                        // إظهار رسالة تحذير إذا كانت الحقول فارغة
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Color(0xFFFFF0CC),
                            content: Text(
                              'يرجى إدخال أسماء جميع اللاعبين',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFF228272),
                                fontSize: 25,
                              ),
                            ),
                          ),
                        );
                      }
                    },
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
