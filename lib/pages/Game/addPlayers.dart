import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mafuso/data/stories.dart';
import 'package:mafuso/pages/Game/setCharacter.dart';
import 'package:mafuso/pages/menu.dart';
import 'package:mafuso/widgets/button.dart';
import 'package:mafuso/widgets/input.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final Stories storiesInstance = Stories();

  int storyId = -1;

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
  void initState() {
    super.initState();
    getStoryId();
  }

  Future<void> getStoryId() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? doneStories = prefs.getStringList('doneStories');

    List<int> usedIds = doneStories?.map(int.parse).toList() ?? [];
    List<int> availableIds =
        List.generate(
          storiesInstance.stories.length,
          (index) => index,
        ).where((id) => !usedIds.contains(id)).toList();

    if (availableIds.isNotEmpty) {
      int newStoryId = availableIds[Random().nextInt(availableIds.length)];
      setState(() {
        storyId = newStoryId;
      });
    } else {
      setState(() {
        storyId = -1;
      });
    }
    print("-------------------------------------------------------------------------------$doneStories");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF822222),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child:
              storyId == -1
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "مفيش قضايا تاني لحد دلوقتي\n اتاكد من تحديث التطبيق",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFFF0CC),
                          fontSize: 40,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Button(
                          title: 'أرجع للقائمة',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Menu()),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Text(
                          'ادخل اسماء اللاعبين',
                          style: TextStyle(
                            color: Color(0xFFFFF0CC),
                            fontSize: 40,
                          ),
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
                            onTap: () async {
                              if (kIsWeb) {
                                await AudioPlayer().play(
                                  UrlSource('assets/sounds/click.mp3'),
                                );
                              } else {
                                await AudioPlayer().play(
                                  AssetSource('sounds/click.mp3'),
                                );
                              }
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
                                          storyId: storyId,
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('storyId', storyId));
  }
}
